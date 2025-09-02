import 'package:better_player/better_player.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/provider/course_details_provider.dart';
import 'package:etutor/features/my_course/widgets/testimonial_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FreeContentVedioplayer extends StatefulWidget {
  final String videolink;
  final String videoTitle;
  final String videoSource;
  final String videohls;

  const FreeContentVedioplayer({
    super.key,
    required this.videolink,
    required this.videoTitle,
    required this.videoSource,
    required this.videohls,
  });

  @override
  State<FreeContentVedioplayer> createState() => _FreeContentVedioplayer();
}

class _FreeContentVedioplayer extends State<FreeContentVedioplayer> {
  bool isLoading = true;
   CourseDetailsProvider courseDetailsProvider = CourseDetailsProvider();


  BetterPlayerController? betterPlayerController;
  YoutubePlayerController? youtubePlayerController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  void initializePlayer() {
    if (widget.videoSource == "3") {
      //  Use BetterPlayer with HLS
      betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
          looping: false,
          aspectRatio: 16 / 9,
        ),
        betterPlayerDataSource: BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          widget.videolink,
        ),
      );
    } else {
      //  Use YouTube Player
      final videoId = YoutubePlayer.convertUrlToId(widget.videolink);
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId ?? "",
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
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
    courseDetailsProvider = context.watch<CourseDetailsProvider>();
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  //  Video Player (Dynamic)
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: widget.videoSource == "3"
                        ? BetterPlayer(controller: betterPlayerController!)
                        : YoutubePlayer(
                            controller: youtubePlayerController!,
                            showVideoProgressIndicator: true,
                          ),
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
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  //  Reviews Section
                  Container(
                      width: MediaQuery.of(context).size.width,
                      color: AppColor.greyCardBackground,
                      child: const Center(
                          child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Reviews",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ))),

                  //  Testimonials List
                  courseDetailsProvider.reviews.isEmpty 
                  ? Text("no reviews")
                  :Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                        itemCount: courseDetailsProvider.reviews.length,
                        itemBuilder: (context, index) 
                        {
                         final reviews =courseDetailsProvider.reviews[index];
                          return TestimonialCard(
                            username: reviews.userName ?? '',
                        description: reviews.comment ?? '',
                        userimage: reviews.image ?? '',
                        rating: reviews.rating ?? '',);}
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}