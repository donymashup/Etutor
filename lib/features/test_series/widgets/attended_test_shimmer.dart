import 'package:dotted_border/dotted_border.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AttendedTestShimmer extends StatelessWidget {
  const AttendedTestShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: DottedBorder(
                color: AppColor.greyIconDark,
                strokeWidth: 1.5,
                borderType: BorderType.RRect,
                radius: const Radius.circular(16),
                dashPattern: const [6, 3],
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.shade100,
                              child: Card()),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  // width: double.infinity,
                                  color: Colors.grey.shade300,
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  height: 20,
                                  // width: double.infinity,
                                  color: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          OutlinedButton(
                            onPressed: null,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                            ),
                            child: Text(
                              "",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 20,
                                width: 100,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(height: 2),
                              Container(
                                height: 20,
                                width: 100,
                                color: Colors.grey.shade300,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 20,
                                width: 100,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(height: 2),
                              Container(
                                height: 20,
                                width: 100,
                                color: Colors.grey.shade300,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
