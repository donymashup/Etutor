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
    final media = MediaQuery.of(context);
    return Container(
      width: media.size.width * 0.44,
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () {}, // TODO: Add navigation or details
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
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
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.broken_image,
                            color: Colors.grey, size: 32),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: ratingtoStar(rating),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
