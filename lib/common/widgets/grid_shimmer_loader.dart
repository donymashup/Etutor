import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridShimmeLoader extends StatelessWidget {
  const GridShimmeLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 12, 
        runSpacing: 12,
        children: List.generate(6, (index) { 
          return Container(
          width: (MediaQuery.of(context).size.width - 56) / 2,
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
      ),
    );
  }
}
