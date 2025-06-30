import 'package:better_player/better_player.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/screens/course_overview_screen.dart';
import 'package:etutor/features/my_course/widgets/testimonial_card.dart';
import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

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
  late BetterPlayerController betterPlayerController;

  @override
  void initState() {
    super.initState();
    initializePlayer("https://media.istockphoto.com/id/1854905414/video/speed-ramp-male-player-in-red-outfit-outplaying-his-opponents-in-a-football-game.mp4?s=mp4-640x640-is&k=20&c=lFRmcGTDZxlqP6cBnJguufewDafJXljQscbPwVRcHuQ=");
  }

  void initializePlayer(String url) {
    betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        url,
      ),
    );

    setState(() {
      isLoading = false;
    });
  }

  void changeVideo(String url, int index) {
    betterPlayerController.setupDataSource(BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
    ));
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
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // Video Player
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: BetterPlayer(controller: betterPlayerController),
                  ),

                  // Video Title Bar
                  Container(
                    // color: AppColor.lightOrange,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              "Foundation of Mathematics",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.bookmark_add_rounded),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: AppColor.greyCardBackground,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Reviews",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                      ))),
                  // SizedBox(height: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                        itemCount: testimonials.length,
                        itemBuilder: (context, index) => TestimonialCard(
                            username: testimonials[index].username,
                            description: testimonials[index].description,
                            userimage: testimonials[index].userimage)),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}