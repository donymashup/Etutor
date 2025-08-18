// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// class ListviewShimmerLoader extends StatelessWidget {
//   const ListviewShimmerLoader({super.key});

//   @override
//   Widget build(BuildContext context) {
//      final screenWidth = MediaQuery.of(context).size.width;
//     final availableWidth = screenWidth - 60; 
//     final spacing = 12.0;
//     final cardWidth = (availableWidth - spacing); 

//     return ListView.separated(
//       scrollDirection: Axis.vertical,
//       itemCount: 4,
//       separatorBuilder: (context, index) => SizedBox(width: spacing),
//       itemBuilder: (context, index) {
//         return Container(
//           width: cardWidth,
//           child: Card(
//             child: Shimmer.fromColors(
//               baseColor: Colors.grey.shade300,
//               highlightColor: Colors.grey.shade100,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 100,
//                       width: double.infinity,
//                       color: Colors.grey.shade300,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 12,
//                           width: double.infinity,
//                           color: Colors.grey.shade300,
//                         ),
//                         SizedBox(height: 4),
//                         Container(
//                           height: 12,
//                           width: 100,
//                           color: Colors.grey.shade300,
//                         ),
//                         SizedBox(height: 4),
//                         Container(
//                           height: 10,
//                           width: 60,
//                           color: Colors.grey.shade300,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListviewShimmerLoader extends StatelessWidget {
  const ListviewShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: 4,
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(width: 12),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 16,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 14,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 12,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}