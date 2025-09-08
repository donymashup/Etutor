import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course/provider/bookmark_provider.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  final String title;
  final String link;
  final String contentId;

  const PdfViewer({
    super.key,
    required this.link,
    required this.title,
    required this.contentId,
  });

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  BookmarkProvider bookmarkProvider = BookmarkProvider();
  @override
  void initState() {
    context.read<BookmarkProvider>().checkBookMark(
        context: context, contentid: widget.contentId, type: 'materials');

    // Insert timeline API call
    context.read<SubcribedCourseProvider>().insertTimelines(
          context: context,
          contentid: widget.contentId,
          type: "materials",
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bookmarkProvider = context.watch<BookmarkProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: bookmarkProvider.isLoading
                ? null
                : () async {
                    await context.read<BookmarkProvider>().makeBookMark(
                        context: context,
                        contentid: widget.contentId,
                        type: 'materials');
                  },
            icon: bookmarkProvider.isbookmarked
                ? Icon(
                    Icons.bookmark_rounded,
                    color: AppColor.videoIconColor,
                  )
                : Icon(Icons.bookmark_outline),
          )
        ],
      ),
      body: SfPdfViewer.network(widget.link),
    );
  }
}
