import 'package:cached_network_image/cached_network_image.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CoursesList extends StatelessWidget {
  final String imagePath;
  final double rating;
  final String title;

  const CoursesList({
    super.key,
    required this.imagePath,
    required this.rating,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      // height: ,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Image
          // Container(
          //   height: MediaQuery.of(context).size.width * 0.22,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(16),
          //   ),
          //   child: CachedNetworkImage(
          //       imageUrl: imagePath,
          //       placeholder: (context, url) => Shimmer.fromColors(
          //               baseColor: Colors.grey[300]!,
          //               highlightColor: Colors.grey[100]!,
          //               child: Container(
          //                 color: Colors.white,
          //               ),
          //             ),
          //             errorWidget: (context, url, error) => Icon(Icons.error),)
          // ),
          Container(
            height: MediaQuery.of(context).size.width * 0.22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 16 / 9, 
                child: CachedNetworkImage(
                  imageUrl: imagePath,
                  fit: BoxFit.cover, 
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Course Title
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 5),

          // Stars + Rating Row
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ratingtoStar(rating),
                Text(
                  rating.toString(),
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
