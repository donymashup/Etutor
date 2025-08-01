// import 'dart:async';
// import 'package:etutor/features/home/model/bannerimages_model.dart';
// import 'package:etutor/features/home/provider/homepage_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CarouselScreen extends StatefulWidget {
//   @override
//   _CarouselScreenState createState() => _CarouselScreenState();
// }

// class _CarouselScreenState extends State<CarouselScreen> {
//   final PageController _controller = PageController();
//   int _currentPage = 0;
//   Timer? _timer;
//   List<Data> imagePaths = [];

//   @override
//   void initState() {
//     super.initState();
//     _startAutoScroll();
//     _bannerImages();
//   }

//   void _startAutoScroll() {
//     _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
//       if (_currentPage < imagePaths.length - 1) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//     _controller.animateToPage(
//         _currentPage,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeIn,
//       );
//     });
//   }

//   Future<void> _bannerImages() async {
//     final homepageProvider  = context.read<HomepageProvider>();
//     await homepageProvider.bannerimages(context);
//     imagePaths = homepageProvider.bannerurl;
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double carouselHeight = screenHeight * 0.23;

//     return  Column(
//         children: [
//           SizedBox(
//             height: carouselHeight,
//             width: double.infinity,
//             child: PageView.builder(
//               controller: _controller,
//               itemCount: imagePaths.length,
//               onPageChanged: (index) {
//                 setState(() => _currentPage = index);
//               },
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(5),
//                     child: Image.network(
//                       imagePaths[index].image!,
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(imagePaths.length, (index) {
//               return Container(
//                 margin: EdgeInsets.symmetric(horizontal: 4),
//                 width: _currentPage == index ? 12 : 8,
//                 height:8,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                  color: _currentPage == index ? Colors.blue : Colors.grey,
//                 ),
//               );
//             }),
//           ),
//         ],
//       );
    
//   }
// }/

import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/home/model/bannerimages_model.dart';
import 'package:etutor/features/home/provider/homepage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CarouselScreen extends StatefulWidget {
  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _bannerImages();
  }

  void _startAutoScroll(int imageCount) {
    _timer?.cancel();
    
    if (imageCount > 1) {
      _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
        if (_currentPage < imageCount - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        
        if (_controller.hasClients) {
          _controller.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      });
    }
  }

  Future<void> _bannerImages() async {
    final homepageProvider = context.read<HomepageProvider>();
    await homepageProvider.bannerimages(context);
    if (mounted) {
      final imageCount = homepageProvider.bannerurl.length;
      if (imageCount > 0) {
        _startAutoScroll(imageCount);
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double carouselHeight = screenHeight * 0.23;

    return Consumer<HomepageProvider>(
      builder: (context, homepageProvider, child) {
        // Show loading indicator while fetching data
        if (homepageProvider.isLoading) {
          return SizedBox(
            height: carouselHeight,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final imagePaths = homepageProvider.bannerurl;
        // Show message if no images available
        if (imagePaths.isEmpty) {
          return SizedBox(
            height: carouselHeight,
            child: Center(
              child: Text(
                'No banner images available',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
          );
        }
        return Column(
          children: [
            SizedBox(
              height: carouselHeight,
              width: double.infinity,
              child: PageView.builder(
                controller: _controller,
                itemCount: imagePaths.length,
                onPageChanged: (index) {
                   homepageProvider.setCurrentCarouselPage(index);
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl :imagePaths[index].image ?? 'https://d2p9rkckgtge3j.cloudfront.net/slider/1ec100f76c901d96518667fc71cd821d9UID1.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
        if (imagePaths.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imagePaths.length, (index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 3),
                width: _currentPage == index ? 24 : 12,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: _currentPage == index ? AppColor.primaryColor : const Color.fromARGB(255, 211, 211, 211),
                ),
              );
            }),
          ),
          ],
        );
      },
    );
  }
}