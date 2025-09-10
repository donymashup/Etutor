import 'package:better_player/better_player.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/provider/course_details_provider.dart';
import 'package:etutor/features/subscribed_course/provider/bookmark_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BookmarkVedioPlayer extends StatefulWidget {
  final String videolink;
  final String videoTitle;
  final String videoSource;
  final String videohls;
  final String contentId;

  const BookmarkVedioPlayer({
    super.key,
    required this.videolink,
    required this.videoTitle,
    required this.videoSource,
    required this.videohls,
    required this.contentId,
  });

  @override
  State<BookmarkVedioPlayer> createState() => _BookmarkVedioPlayer();
}

class _BookmarkVedioPlayer extends State<BookmarkVedioPlayer> {
  bool isLoading = true;
  BookmarkProvider bookmarkProvider = BookmarkProvider();


  BetterPlayerController? betterPlayerController;
  YoutubePlayerController? youtubePlayerController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
       // Bookmark check
      context.read<BookmarkProvider>().checkBookMark(
            context: context,
            contentid: widget.contentId,
            type: 'videos',
          );
  }

  void initializePlayer() {
    if (widget.videoSource == "1") {
        //  Use YouTube Player
      final videoId = YoutubePlayer.convertUrlToId(widget.videolink);
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId ?? "",
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
      
    } else {
    //  Use BetterPlayer with HLS
      betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
          looping: false,
          aspectRatio: 16 / 9,
        ),
        betterPlayerDataSource: BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          widget.videohls,
        ),
      );
    }

    setState(() => isLoading = false);
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
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  //  Video Player (Dynamic)
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: widget.videoSource == "1"
                        ? YoutubePlayer(
                            controller: youtubePlayerController!,
                            showVideoProgressIndicator: true,
                          )
                        :BetterPlayer(controller: betterPlayerController!)
                        
                  ),

                  //  Video Title Bar
                  Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              widget.videoTitle,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
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
                                        contentid: widget.contentId,
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

                 
                ],
              ),
      ),
    );
  }
}