import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/model/batch_folder_content_model.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/subscribed_course/screens/contents_folder_details.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeCourseContentsScreen extends StatelessWidget {
 // final BatchFolderContentModel batchFolderContent;
  SubcribedCourseProvider subcribedCourseProvider = SubcribedCourseProvider();
  final String courseid;

   SeeCourseContentsScreen({super.key, 
   // required this.batchFolderContent,
   required this.courseid});

  @override
  Widget build(BuildContext context) {
    subcribedCourseProvider =context.watch<SubcribedCourseProvider>();
   // final folders = batchFolderContent.folders ?? [];

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: const Text(
          "Course Contents Folders",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: subcribedCourseProvider.batchFolderContent!.folders!.length,
        itemBuilder: (context, index) {
          final folder = subcribedCourseProvider.batchFolderContent!.folders![index];
          return folderCard(context, folder.id ?? "0", folder.name ?? "Folder");
        },
      ),
    );
  }

  Widget folderCard(BuildContext context, String folderId, String title) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          decoration: BoxDecoration(
            color: AppColor.lightYellowBg,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: const FluentUiEmojiIcon(
            fl: Fluents.flOpenFileFolder,
            h: 28,
            w: 28,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () async {
        
          await context.read<SubcribedCourseProvider>().fetchBatchFolderContent(
                context: context,
                parentid: folderId ,
                courseid: courseid,
              );
       final batchContent =
              context.watch<SubcribedCourseProvider>().batchFolderContent;

          if (batchContent != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                     FolderDetailsScreen(
                      folderName: title,
                      //batchFolderContent: batchContent,
                      courseid: courseid,
                     ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No folders found")),
            );
          }
        },
      ),
    );
  }
}
