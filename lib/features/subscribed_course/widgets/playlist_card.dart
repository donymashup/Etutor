// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// class PlaylistCardWidget extends StatelessWidget {
//   final String title;
//   final String duration;
//   final String thumbnail;
//   final String videoSource;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const PlaylistCardWidget({
//     Key? key,
//     required this.title,
//     required this.duration,
//     required this.thumbnail,
//     required this.videoSource,
//     required this.isSelected,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.3),
//             width: 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 100,
//               height: 80,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Stack(
//                 children: [
//                   // Thumbnail
//                   CachedNetworkImage(
//                     imageUrl: thumbnail,
//                     fit: BoxFit.cover,
//                     width: 100,
//                     height: 80,
//                     placeholder: (context, url) => Shimmer.fromColors(
//                       baseColor: Colors.grey[300]!,
//                       highlightColor: Colors.grey[100]!,
//                       child: Container(
//                         width: 100,
//                         height: 80,
//                         color: Colors.white,
//                       ),
//                     ),
//                     errorWidget: (context, url, error) => const Icon(Icons.error),
//                   ),
//                  // Video source indicator
//                   Positioned(
//                     bottom: 4,
//                     right: 4,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 4,
//                         vertical: 2,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.7),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Icon(
//                         videoSource == "1" ? Icons.play_arrow : Icons.videocam,
//                         color: Colors.white,
//                         size: 12,
//                       ),
//                     ),
//                   ),

//                 ],
//               ),
//             ),
//             const SizedBox(width: 12),
//             // Video details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
//                       color: isSelected ? Colors.blue : Colors.black87,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Icon(
//                        Icons.play_circle,
//                         size: 14,
//                         color: Colors.grey[600],
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                        "$duration min",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             // Play indicator for selected video
//             if (isSelected)
//               const Icon(
//                 Icons.play_arrow,
//                 color: Colors.blue,
//                 size: 20,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlaylistCardWidget extends StatelessWidget {
  final String title;
  final String duration;
  final String thumbnail;
  final String videoSource;
  final bool isSelected;
  final VoidCallback onTap;

  const PlaylistCardWidget({
    Key? key,
    required this.title,
    required this.duration,
    required this.thumbnail,
    required this.videoSource,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            /// Thumbnail
            Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: thumbnail,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 80,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100,
                        height: 80,
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        videoSource == "1"
                            ? Icons.play_arrow
                            : Icons.videocam,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            /// Details + trailing play icon
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Video details (takes all remaining space except play icon)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected ? Colors.blue : Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.play_circle,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "$duration min",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// Play indicator for selected video (vertically centered)
                  if (isSelected)
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
