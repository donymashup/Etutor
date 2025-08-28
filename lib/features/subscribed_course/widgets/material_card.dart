import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course/screens/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class MaterialCard extends StatefulWidget {
  final String materialName;
  final String materialDescription;
  final String link;
  final String contentId;

  const MaterialCard({
    super.key,
    required this.materialName,
    required this.materialDescription,
    required this.link,
    required this.contentId,
  });

  @override
  State<MaterialCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<MaterialCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewer(link:widget.link, title:widget.materialName, contentId: widget.contentId,)
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.greyStroke),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                 leadingIconCard(
                Iconify(
                  Mdi.pdf_box,
                  size: 30,
                  color: AppColor.redBarGraph,
                ),
                AppColor.lightRedCardBackground),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.materialName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.materialDescription,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget leadingIconCard(Widget icon, Color bgColor) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: bgColor),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          child: icon,
        ));
  }
}
