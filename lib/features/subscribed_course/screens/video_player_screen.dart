import 'package:better_player/better_player.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/widgets/testimonial_card.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videolink;
  final String videoTitle;
  final String videoSource;
  final String videohls;

  const VideoPlayerScreen({
    super.key,
    required this.videolink,
    required this.videoTitle,
    required this.videoSource,
    required this.videohls,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class Testimonials {
  String username;
  String userimage;
  String description;

  Testimonials({
    required this.username,
    required this.description,
    required this.userimage,
  });
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool isLoading = true;

  BetterPlayerController? betterPlayerController;
  YoutubePlayerController? youtubePlayerController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  void initializePlayer() {
    if (widget.videoSource == "2") {
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

  List<Testimonials> testimonials = [
    Testimonials(
        username: "Arjun Ashokan",
        description:
            "eTutor has completely changed the way I learn—it's interactive, easy to use, and keeps me engaged every step of the way!",
        userimage: "assets/images/arjun.webp"),
    Testimonials(
        username: "Aiswarya Lakshmi",
        description:
            "Thanks to eTutor, I can now study anytime, anywhere with expert guidance and structured lessons tailored just for me.",
        userimage: "assets/images/aish.jpg"),
    Testimonials(
        username: "Basil Joseph",
        description:
            "The personalized learning experience on eTutor helped me improve my scores and stay motivated throughout the course",
        userimage: "assets/images/basil.jpg"),
    Testimonials(
        username: "Mamitha Baiju",
        description:
            "I love how eTutor breaks down tough subjects into simple concepts. It's like having a personal tutor at home.",
        userimage: "assets/images/mamitha.webp"),
    Testimonials(
        username: "Gopika Ramesh",
        description:
            "With eTutor, I finally feel confident in subjects I used to struggle with. It's the best study companion!",
        userimage: "assets/images/gopika.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  //  Video Player (Dynamic)
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: widget.videoSource == "2"
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
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_add_rounded),
                        )
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                        itemCount: testimonials.length,
                        itemBuilder: (context, index) => TestimonialCard(
                            username: testimonials[index].username,
                            description: testimonials[index].description,
                            userimage: testimonials[index].userimage,
                            rating: '5',),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
