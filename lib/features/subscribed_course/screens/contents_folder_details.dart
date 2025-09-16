import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/model/batch_folder_content_model.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FolderDetailsScreen extends StatelessWidget {
  final String folderName;
  SubcribedCourseProvider contents = SubcribedCourseProvider();
 // final BatchFolderContentModel batchFolderContent;
  final String courseid;

   FolderDetailsScreen({
    super.key,
    required this.folderName,
 //   required this.batchFolderContent,
    required this.courseid,
  });

  @override
  Widget build(BuildContext context) {
   // final contents = batchFolderContent.folders ?? [];
   contents = context.watch<SubcribedCourseProvider>();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: Text(
          folderName,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
      ),
      body: contents.batchFolderContent!.folders!.isEmpty
          ? const Center(child: Text('No files found', style: TextStyle(fontSize: 16)))
          : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: contents.batchFolderContent!.folders!.length,
              itemBuilder: (context, index) {
                final item = contents.batchFolderContent!.folders![index];
                return item.type == "folder"
                    ? folderCard(context, item.id ?? "0", item.name ?? "Folder")
                    : fileCard(context, item.name ?? "File", item.type ?? "", item.link ?? "");
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
        leading: const Icon(Icons.folder, color: Colors.amber),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () async {
          await context.read<SubcribedCourseProvider>().fetchBatchFolderContent(
                context: context,
                parentid: folderId,
                courseid: courseid,
              );

          final batchContent =
              context.watch<SubcribedCourseProvider>().batchFolderContent;

          if (batchContent != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FolderDetailsScreen(
                  folderName: title,
                //  batchFolderContent: batchContent,
                  courseid: courseid,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget fileCard(BuildContext context, String fileName, String type, String link) {
    IconData icon;
    Color color;

    switch (type) {
      case "pdf":
        icon = Icons.picture_as_pdf;
        color = Colors.red;
        break;
      case "image":
        icon = Icons.image;
        color = Colors.blue;
        break;
      case "video":
        icon = Icons.play_circle_fill;
        color = Colors.purple;
        break;
      case "test":
        icon = Icons.assignment;
        color = Colors.green;
        break;
      default:
        icon = Icons.insert_drive_file;
        color = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(fileName, style: const TextStyle(fontWeight: FontWeight.w500)),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Opening $type: $fileName ($link)")),
          );
          // TODO: open actual file viewer / video player
        },
      ),
    );
  }
}
