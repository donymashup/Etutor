import 'package:better_player/better_player.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course/model/videos_model.dart'as videos_model;
import 'package:etutor/features/subscribed_course/provider/bookmark_provider.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/subscribed_course/provider/vedio_playlist_provider.dart';
import 'package:etutor/features/subscribed_course/widgets/playlist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final List<videos_model.Data> playlist;
  final int initialIndex;
  final String contentid;

  const VideoPlayerScreen({
    super.key,
    required this.playlist,
    required this.contentid,
    this.initialIndex = 0,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> with WidgetsBindingObserver {
  BetterPlayerController? betterPlayerController;
  YoutubePlayerController? youtubePlayerController;
  String? currentVideoId;
  bool isInitializing = false;
  bool isDisposing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      
      final provider = Provider.of<VideoPlayerProvider>(context, listen: false);
      provider.setPlaylist(widget.playlist);
      provider.selectVideo(widget.initialIndex);
      initializePlayer(provider.currentVideo!);
      checkBookMark(widget.contentid);
    });
  }

  void checkBookMark(String id) {
    if (!mounted) return;
    
    context.read<BookmarkProvider>().checkBookMark(
          context: context,
          contentid: id,
          type: 'videos',
        );
    context.read<SubcribedCourseProvider>().insertTimelines(
          context: context,
          contentid: id,
          type: "videos",
        );
  }

  void initializePlayer(videos_model.Data video) async {
    // Don't reinitialize if it's the same video
    if (currentVideoId == video.videoid && 
        (betterPlayerController != null || youtubePlayerController != null)) {
      return;
    }

    if (isInitializing || isDisposing) return;
    isInitializing = true;

    // Cleanup based on video source
    if (video.source == "1") {
      // Switching to YouTube - cleanup BetterPlayer synchronously
      if (betterPlayerController != null) {
        try {
          await betterPlayerController?.pause();
           betterPlayerController?.dispose();
        } catch (e) {
          print('Error disposing BetterPlayer: $e');
        }
        betterPlayerController = null;
      }
      
      currentVideoId = video.videoid;
      
      // Create YouTube Player
      final videoId = YoutubePlayer.convertUrlToId(video.link ?? "");
      if (videoId != null && mounted) {
        youtubePlayerController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            enableCaption: false,
            forceHD: false,
          ),
        );
      }
    } else {
      // Switching to BetterPlayer - cleanup YouTube synchronously
      if (youtubePlayerController != null) {
        try {
          youtubePlayerController?.pause();
          youtubePlayerController?.dispose();
        } catch (e) {
          print('Error disposing YouTube: $e');
        }
        youtubePlayerController = null;
      }
      
      currentVideoId = video.videoid;
      
      // Create BetterPlayer with optimized settings
      if (mounted) {
        betterPlayerController = BetterPlayerController(
          BetterPlayerConfiguration(
            autoPlay: true,
            looping: false,
            aspectRatio: 16 / 9,
            fit: BoxFit.contain,
            autoDispose: false,
            allowedScreenSleep: false,
            // CRITICAL: Handle fullscreen manually to prevent orientation issues
            autoDetectFullscreenDeviceOrientation: true,
            controlsConfiguration: const BetterPlayerControlsConfiguration(
              enableFullscreen: true,
              enableOverflowMenu: false,
              enablePlayPause: true,
              enableMute: true,
              enableProgressBar: true,
              enableProgressText: true,
              enableSkips: false,
            ),
            eventListener: (BetterPlayerEvent event) {
              // Listen for fullscreen events
              if (event.betterPlayerEventType == BetterPlayerEventType.openFullscreen) {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
              } else if (event.betterPlayerEventType == BetterPlayerEventType.hideFullscreen) {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
              }
            },
          ),
          betterPlayerDataSource: BetterPlayerDataSource(
            BetterPlayerDataSourceType.network,
            video.hls ?? '',
            cacheConfiguration: const BetterPlayerCacheConfiguration(
              useCache: true,
              preCacheSize: 10 * 1024 * 1024, // 10MB pre-cache
              maxCacheSize: 50 * 1024 * 1024, // 50MB max cache
              maxCacheFileSize: 30 * 1024 * 1024, // 30MB per file
            ),
          ),
        );
      }
    }

    isInitializing = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    isDisposing = true;
    WidgetsBinding.instance.removeObserver(this);
    
    // Synchronously dispose controllers
    try {
      betterPlayerController?.pause();
      betterPlayerController?.dispose();
    } catch (e) {
      print('Error disposing BetterPlayer in dispose: $e');
    }
    
    try {
      youtubePlayerController?.pause();
      youtubePlayerController?.dispose();
    } catch (e) {
      print('Error disposing YouTube in dispose: $e');
    }
    
    // Reset orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      betterPlayerController?.pause();
      youtubePlayerController?.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          await SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Consumer<VideoPlayerProvider>(
          builder: (context, provider, child) {
            if (provider.currentVideo == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final currentVideo = provider.currentVideo!;

            return OrientationBuilder(
              builder: (context, orientation) {
                final isLandscape = orientation == Orientation.landscape;

                if (isLandscape) {
                  // LANDSCAPE - Fullscreen video only
                  return Container(
                    color: Colors.black,
                    child: Center(
                      child: currentVideo.source == "1"
                          ? (youtubePlayerController != null
                              ? YoutubePlayer(
                                  controller: youtubePlayerController!,
                                  showVideoProgressIndicator: true,
                                )
                              : const CircularProgressIndicator())
                          : (betterPlayerController != null
                              ? AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: BetterPlayer(
                                    controller: betterPlayerController!,
                                  ),
                                )
                              : const CircularProgressIndicator()),
                    ),
                  );
                }

                // PORTRAIT - Full UI
                return Column(
                  children: [
                    // Video Player
                    Container(
                      color: Colors.black,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: currentVideo.source == "1"
                            ? (youtubePlayerController != null
                                ? YoutubePlayer(
                                    controller: youtubePlayerController!,
                                    showVideoProgressIndicator: true,
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ))
                            : (betterPlayerController != null
                                ? BetterPlayer(
                                    controller: betterPlayerController!,
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  )),
                      ),
                    ),
                    // Video Title Bar
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              currentVideo.name ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Consumer<BookmarkProvider>(
                            builder: (context, bookmarkProvider, child) {
                              return IconButton(
                                onPressed: bookmarkProvider.isLoading
                                    ? null
                                     : () async {
                                        await context
                                            .read<BookmarkProvider>()
                                            .makeBookMark(
                                              context: context,
                                              contentid: currentVideo.id ?? "",
                                              type: 'videos',
                                            );
                                      },
                                icon: bookmarkProvider.isbookmarked
                                    ? Icon(
                                        Icons.bookmark_rounded,
                                        color: AppColor.videoIconColor,
                                      )
                                    : const Icon(Icons.bookmark_outline),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Playlist Header
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: AppColor.greyCardBackground,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Playlist (${provider.playlist.length} videos)",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: provider.selectedIndex > 0
                                      ? () {
                                          provider.previousVideo();
                                          initializePlayer(provider.currentVideo!);
                                          checkBookMark(provider.currentVideo!.videoid ?? '');
                                        }
                                      : null,
                                  icon: const Icon(Icons.skip_previous),
                                  iconSize: 20,
                                ),
                                IconButton(
                                  onPressed: provider.selectedIndex <
                                          provider.playlist.length - 1
                                      ? () {
                                          provider.nextVideo();
                                          initializePlayer(provider.currentVideo!);
                                          checkBookMark(provider.currentVideo!.videoid ?? '');
                                        }
                                      : null,
                                  icon: const Icon(Icons.skip_next),
                                  iconSize: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Playlist
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.playlist.length,
                        itemBuilder: (context, index) {
                          final video = provider.playlist[index];
                          final isSelected = index == provider.selectedIndex;

                          return PlaylistCardWidget(
                            title: video.name ?? '',
                            duration: video.duration ?? '',
                            thumbnail: video.thumbnail ?? '',
                            videoSource: video.source ?? '',
                            isSelected: isSelected,
                            onTap: () {
                              provider.selectVideo(index);
                              initializePlayer(video);
                              checkBookMark(video.videoid ?? '');
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}


