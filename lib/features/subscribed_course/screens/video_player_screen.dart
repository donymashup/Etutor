import 'package:better_player/better_player.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course/model/videos_model.dart' as videos_model;
import 'package:etutor/features/subscribed_course/provider/bookmark_provider.dart';
import 'package:etutor/features/subscribed_course/provider/vedio_playlist_provider.dart';
import 'package:etutor/features/subscribed_course/widgets/playlist_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// Import the provider and widget files created above
// import 'video_player_provider.dart';
// import 'playlist_card_widget.dart';

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

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  BetterPlayerController? betterPlayerController;
  YoutubePlayerController? youtubePlayerController;
  BookmarkProvider bookmarkProvider = BookmarkProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<VideoPlayerProvider>(context, listen: false);
      provider.setPlaylist(widget.playlist);
      provider.selectVideo(widget.initialIndex);
      initializePlayer(provider.currentVideo!);
      context.read<BookmarkProvider>().checkBookMark(context: context, contentid: widget.contentid, type: 'videos');
    });
  }

  // void _load() async{
  //   await context.read<BookmarkProvider>().checkBookMark(context: context, contentid: contentid, type: type)
  // }

  void initializePlayer(videos_model.Data video) {
    // Dispose previous controllers
    betterPlayerController?.dispose();
    youtubePlayerController?.dispose();

    if (video.source == "2") {
      // Use BetterPlayer with HLS
      betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
          autoPlay: true,
          looping: false,
          aspectRatio: 16 / 9,
        ),
        betterPlayerDataSource: BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          video.hls ?? '',
        ),
      );
    } else {
      // Use YouTube Player
      final videoId = YoutubePlayer.convertUrlToId(video.link ?? "");
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId ?? "",
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    betterPlayerController?.dispose();
    youtubePlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bookmarkProvider =  context.watch<BookmarkProvider>();
    return SafeArea(
      child: Scaffold(
        body: Consumer<VideoPlayerProvider>(
          builder: (context, provider, child) {
            if (provider.currentVideo == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final currentVideo = provider.currentVideo!;
            
            return Column(
              children: [
                // Video Player (Dynamic)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: currentVideo.source == "2"
                      ? betterPlayerController != null
                          ? BetterPlayer(controller: betterPlayerController!)
                          : const Center(child: CircularProgressIndicator())
                      : youtubePlayerController != null
                          ? YoutubePlayer(
                              controller: youtubePlayerController!,
                              showVideoProgressIndicator: true,
                            )
                          : const Center(child: CircularProgressIndicator()),
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
                      IconButton(
                        onPressed: bookmarkProvider.isLoading ? null : () async{
                          await context.read<BookmarkProvider>().makeBookMark(context: context, contentid:widget.contentid, type: 'videos');
                        },
                        icon: bookmarkProvider.isbookmarked ? Icon(Icons.bookmark_rounded,color: AppColor.videoIconColor,) : Icon(Icons.bookmark_outline),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Playlist Section Header
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
                        // Navigation buttons
                        Row(
                          children: [
                            IconButton(
                              onPressed: provider.selectedIndex > 0
                                  ? () {
                                      provider.previousVideo();
                                      initializePlayer(provider.currentVideo!);
                                    }
                                  : null,
                              icon: const Icon(Icons.skip_previous),
                              iconSize: 20,
                            ),
                            IconButton(
                              onPressed: provider.selectedIndex < provider.playlist.length - 1
                                  ? () {
                                      provider.nextVideo();
                                      initializePlayer(provider.currentVideo!);
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

                // Playlist Videos List
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.playlist.length,
                    itemBuilder: (context, index) {
                      final video = provider.playlist[index];
                      final isSelected = index == provider.selectedIndex;
                      
                      return PlaylistCardWidget(
                        title: video.name ??'',
                        duration: video.duration ??'',
                        thumbnail: video.thumbnail ?? '',
                        videoSource: video.source ?? '',
                        isSelected: isSelected,
                        onTap: () {
                          provider.selectVideo(index);
                          initializePlayer(video);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}