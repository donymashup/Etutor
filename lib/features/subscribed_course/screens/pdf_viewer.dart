import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  final String title;
  final String link;

  const PdfViewer({
    super.key,
    required this.link,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_add_rounded),
          )
        ],
      ),
      body: SfPdfViewer.network(link),
    );
  }
}
