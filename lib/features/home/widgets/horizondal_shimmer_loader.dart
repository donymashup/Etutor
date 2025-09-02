import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HorizondalShimmerLoader extends StatelessWidget {
  const HorizondalShimmerLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 160,
                margin: EdgeInsets.only(right: 12),
                child: Card(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
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