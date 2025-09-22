import 'package:better_player/better_player.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course/model/videos_model.dart'as videos_model;
import 'package:etutor/features/subscribed_course/provider/bookmark_provider.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/subscribed_course/provider/vedio_playlist_provider.dart';
import 'package:etutor/features/subscribed_course/widgets/playlist_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CousecontentsVideoplayer extends StatefulWidget {
 // final List<videos_model.Data> playlist;
 // final int initialIndex;
  final String contentid;
  final String link;
  final String source;
  final String name;

  const CousecontentsVideoplayer({
    super.key,
  //  required this.playlist,
    required this.contentid,
    required this.link,
    required this.source,
    required this.name
 //   this.initialIndex = 0,
  });

  @override
  State<CousecontentsVideoplayer> createState() => _CousecontentsVideoplayerState();
}

class _CousecontentsVideoplayerState extends State<CousecontentsVideoplayer> {
  BetterPlayerController? betterPlayerController;
  YoutubePlayerController? youtubePlayerController;
  BookmarkProvider bookmarkProvider = BookmarkProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Playlist setup
      final provider = Provider.of<SubcribedCourseProvider>(context, listen: false);
      provider.setLoading(true);
    //  provider.setPlaylist(widget.playlist);
      //provider.selectVideo(widget.initialIndex);
      initializePlayer();
      checkBookMark(widget.contentid);
     
    });
  }
 void checkBookMark(String id){
 // Bookmark check
      context.read<BookmarkProvider>().checkBookMark(
            context: context,
            contentid: id,
            type: 'videos',
          );
      // Insert timeline API call
      context.read<SubcribedCourseProvider>().insertTimelines(
            context: context,
            contentid:id,
            type: "videos",
          );
 }

  void initializePlayer() {
    // Dispose previous controllers
    betterPlayerController?.dispose();
    youtubePlayerController?.dispose();
    final provider = Provider.of<SubcribedCourseProvider>(context, listen: false);
    
    if (widget.source == "1") {
      // Use YouTube Player
      final videoId = YoutubePlayer.convertUrlToId(widget.link);
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
          widget.link,
        ),
      );
    }
     provider.setLoading(false);
  }

  @override
  void dispose() {
    betterPlayerController?.dispose();
    youtubePlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bookmarkProvider = context.watch<BookmarkProvider>();
    final provider = Provider.of<SubcribedCourseProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: provider.isLoading ? const Center(child: CircularProgressIndicator())
        // Consumer<VideoPlayerProvider>(
        //   builder: (context, provider, child) {
        //     if (provider.currentVideo == null) {
        //       return const Center(child: CircularProgressIndicator());
        //     }

        //     final currentVideo = provider.currentVideo!;

        //     return
           :  Column(
              children: [
                // Video Player
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: widget.source == "1"
                      ? youtubePlayerController != null
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
                          widget.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: bookmarkProvider.isLoading
                            ? null
                            : () async {
                                await context
                                    .read<BookmarkProvider>()
                                    .makeBookMark(
                                        context: context,
                                        contentid: widget.contentid,
                                        type: 'videos');
                              },
                        icon: bookmarkProvider.isbookmarked
                            ? Icon(
                                Icons.bookmark_rounded,
                                color: AppColor.videoIconColor,
                              )
                            : Icon(Icons.bookmark_outline),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Playlist Section Header
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   color: AppColor.greyCardBackground,
                //   child: Padding(
                //     padding: const EdgeInsets.all(12.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           "Playlist (${provider.playlist.length} videos)",
                //           style: const TextStyle(
                //             fontWeight: FontWeight.w600,
                //             fontSize: 18,
                //           ),
                //         ),
                //         // Navigation buttons
                //         Row(
                //           children: [
                //             IconButton(
                //               onPressed: provider.selectedIndex > 0
                //                   ? () {
                //                       provider.previousVideo();
                //                       initializePlayer(provider.currentVideo!);
                //                     }
                //                   : null,
                //               icon: const Icon(Icons.skip_previous),
                //               iconSize: 20,
                //             ),
                //             IconButton(
                //               onPressed: provider.selectedIndex <
                //                       provider.playlist.length - 1
                //                   ? () {
                //                       provider.nextVideo();
                //                       initializePlayer(provider.currentVideo!);
                //                     }
                //                   : null,
                //               icon: const Icon(Icons.skip_next),
                //               iconSize: 20,
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // Playlist Videos List
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: provider.playlist.length,
                //     itemBuilder: (context, index) {
                //       final video = provider.playlist[index];
                //       final isSelected = index == provider.selectedIndex;

                //       return PlaylistCardWidget(
                //         title: video.name ?? '',
                //         duration: video.duration ?? '',
                //         thumbnail: video.thumbnail ?? '',
                //         videoSource: video.source ?? '',
                //         isSelected: isSelected,
                //         onTap: () {
                //           provider.selectVideo(index);
                //           initializePlayer(video);
                //           checkBookMark(video.videoid ?? '');
                //         },
                //       );
                //     },
                //   ),
                // ),
              ],
            )
         //},
        ),
    );
   // );
  }
}