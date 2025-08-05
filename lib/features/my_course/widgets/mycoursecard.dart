import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:flutter/material.dart';

class MyCourseCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double rating;
  final bool isFree;
  final double? imgHeight;


  const MyCourseCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.isFree,
    this.imgHeight,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5 - 21,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColor.greyStroke,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: imgHeight,
                    fit: BoxFit.cover,
                  ),
                ),
                //free bageeeeer
                if (isFree)
                  const Positioned(
                    top: 10,
                    left: 10,
                    child: Banner(
                      message: 'FREE',
                      location: BannerLocation.topStart,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 6),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.blackColor,
                    ),
                  ),

              
                  const SizedBox(height: 4),
              

                  // Rating row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     ratingtoStar(rating),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
