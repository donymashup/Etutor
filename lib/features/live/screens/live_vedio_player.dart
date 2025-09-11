import 'package:better_player/better_player.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/live/model/live_class_model.dart' as live_class_model;
import 'package:etutor/features/live/provider/live_class_provider.dart';
import 'package:etutor/features/subscribed_course/widgets/playlist_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LiveVedioPlayer extends StatefulWidget {
  final List<live_class_model.Data> playlist;
  final int initialIndex;
  final String contentid;

  const LiveVedioPlayer({
    super.key,
    required this.playlist,
    required this.contentid,
    this.initialIndex = 0,
  });

  @override
  State<LiveVedioPlayer> createState() => _LiveVideoPlayerState();
}

class _LiveVideoPlayerState extends State<LiveVedioPlayer> {
  BetterPlayerController? betterPlayerController;
  YoutubePlayerController? youtubePlayerController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<LiveClassProvider>(context, listen: false);
      provider.setPlaylist(widget.playlist);
      provider.selectVideo(widget.initialIndex);
      initializePlayer(provider.currentVideo!);
    });
  }
  void initializePlayer(live_class_model.Data video) {
    // Dispose previous controllers
    betterPlayerController?.dispose();
    youtubePlayerController?.dispose();

    if (video.source == "1") {
         // Use YouTube Player
      final videoId = YoutubePlayer.convertUrlToId(video.hls ?? "");
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId ?? "",
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    } else {
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
    }
  }

  @override
  void dispose() {
    betterPlayerController?.dispose();
    youtubePlayerController?.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) {
        final formatter = DateFormat('dd-MM-yyyy');
        return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<LiveClassProvider>(
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
                  child: currentVideo.source == "1"
                      ? 
                       youtubePlayerController != null
                          ? YoutubePlayer(
                              controller: youtubePlayerController!,
                              showVideoProgressIndicator: true,
                            )
                          : const Center(child: CircularProgressIndicator())
                       : betterPlayerController != null
                          ? BetterPlayer(controller: betterPlayerController!)
                          : const Center(child: CircularProgressIndicator())
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
                          currentVideo.title ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
                        title: video.title ??'',
                        duration: video.start ??'',
                        thumbnail: video.avatar ?? '',
                        videoSource: video.start != null
                            ? formatDate(DateTime.parse(video.start!))
                            : '',
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