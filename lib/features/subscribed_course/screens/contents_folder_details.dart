import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/quiz/screens/quiz_instruction_screen.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/subscribed_course/screens/cousecontents_videoplayer.dart';
import 'package:etutor/features/subscribed_course/screens/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FolderDetailsScreen extends StatefulWidget {
  final String folderName;
  final String parentId;
  final String courseid;

  FolderDetailsScreen({
    super.key,
    required this.folderName,
    required this.parentId,
    required this.courseid,
  });

  @override
  State<FolderDetailsScreen> createState() => _FolderDetailsScreenState();
}

class _FolderDetailsScreenState extends State<FolderDetailsScreen> {
  SubcribedCourseProvider contents = SubcribedCourseProvider();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await context.read<SubcribedCourseProvider>().fetchBatchFolderContent(
          context: context,
          parentid: widget.parentId,
          courseid: widget.courseid,
        );
  }

  @override
  Widget build(BuildContext context) {
    contents = context.watch<SubcribedCourseProvider>();
    final batchContent = contents.batchFolderContent;
    if (contents.isLoadingBatchFolder) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: Text(
          widget.folderName,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
      ),
      body: batchContent == null ||
              batchContent.folders == null ||
              batchContent.folders!.isEmpty
          ? const Center(
              child: Text(
                'No files found',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: batchContent.folders!.length,
              itemBuilder: (context, index) {
                final item = batchContent.folders![index];
                debugPrint(item.type);

                if (item.type == "folder") {
                  return folderCard(
                    context,
                    item.id ?? "0",
                    item.name ?? "Folder",
                  );
                } else {
                  return fileCard(
                      context,
                      item.name ?? "Unnamed File",
                      item.type ?? "unknown",
                      item.link ?? "",
                      item.contentid ?? "",
                      item.source ?? "",
                      item.duration ?? "");
                }
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FolderDetailsScreen(
                folderName: title,
                courseid: widget.courseid,
                parentId: folderId,
              ),
            ),
          );
          //  }
        },
      ),
    );
  }

  Widget fileCard(BuildContext context, String fileName, String type,
      String link, String contentId, String source, String duration) {
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
        title:
            Text(fileName, style: const TextStyle(fontWeight: FontWeight.w500)),
        onTap: () {
          if (contentId.isEmpty || contentId == "NA") {
            showSnackbar(context, 'No contents found');
          } else {
            if (type == "pdf") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewer(
                    title: fileName,
                    link: link,
                    contentId: contentId,
                  ),
                ),
              );
            } else if (type == "video") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CousecontentsVideoplayer(
                            contentid: contentId,
                            link: link,
                            source: source,
                            name: fileName,
                          )));
            } else if (type == "test") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuizInstructionPage(duration: duration, questions: '', testName: fileName, testid:contentId, isMain: false,
                            
                          )));
            } else {
              debugPrint("Opening file: $link");
            }
          }
       },
      ),
    );
  }
}
