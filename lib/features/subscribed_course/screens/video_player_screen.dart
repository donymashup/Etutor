// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';

// class VideoPlayerScreen extends StatefulWidget {
//   const VideoPlayerScreen({super.key});

//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   bool isLoading = true;
//   late BetterPlayerController betterPlayerController;
//   int selectedIndex = 0; // Track selected video index

//   final List<String> videoUrls = [
//     "https://media.istockphoto.com/id/1854905414/video/speed-ramp-male-player-in-red-outfit-outplaying-his-opponents-in-a-football-game.mp4?s=mp4-640x640-is&k=20&c=lFRmcGTDZxlqP6cBnJguufewDafJXljQscbPwVRcHuQ=",
//     "https://cdn.pixabay.com/video/2020/06/17/42420-431511648_large.mp4",
//     "https://d3sigpa2r6yn5i.cloudfront.net/transcoded/85DRa92D54G/video.m3u8",
//     "https://d3sigpa2r6yn5i.cloudfront.net/transcoded/9SkEnE92d42/video.m3u8",
//     "https://player.vimeo.com/external/931461126.m3u8?s=8d81b0a23217e40cc7904c52db9c607be07691c5&logging=false"
//   ];
//   @override
//   void initState() {
//     super.initState();
//     initializePlayer(videoUrls[0]); // Load first video initially
//   }

//   void initializePlayer(String url) {
//     betterPlayerController = BetterPlayerController(
//       BetterPlayerConfiguration(
//         autoPlay: true,
//         looping: false,
//         aspectRatio: 16 / 9,
//       ),
//       betterPlayerDataSource: BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         url,
//       ),
//     );

//     setState(() {
//       isLoading = false;
//     });
//   }

//   void changeVideo(String url, int index) {
//     betterPlayerController.setupDataSource(BetterPlayerDataSource(
//       BetterPlayerDataSourceType.network,
//       url,
//     ));

//     setState(() {
//       selectedIndex = index; // Update selected video index
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: isLoading
//             ? Center(child: CircularProgressIndicator())
//             : Column(
//                 children: [
//                   // Video Player
//                   AspectRatio(
//                     aspectRatio: 16 / 9,
//                     child: BetterPlayer(controller: betterPlayerController),
//                   ),

//                   // Video Title Bar
//                   Container(
//                     // color: AppColor.lightOrange,
//                     height: 60,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(14.0),
//                           child: SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.7,
//                             child: Text(
//                               "Foundation of Mathematics",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {},
//                           icon: Icon(Icons.bookmark_add_rounded),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }