import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SubjectShimmerLoader extends StatelessWidget {
  const SubjectShimmerLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - 60; 
    final spacing = 12.0;
    final cardWidth = (availableWidth - spacing) / 2; 

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: List.generate(4, (index) {
        return Container(
          width: cardWidth,
          child: Card(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 12,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 4),
                        Container(
                          height: 12,
                          width: 100,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 4),
                        Container(
                          height: 10,
                          width: 60,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}