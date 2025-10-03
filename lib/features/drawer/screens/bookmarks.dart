import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/drawer/widgets/bookmark_vedio_player.dart';
import 'package:etutor/features/subscribed_course/provider/bookmark_provider.dart';
import 'package:etutor/features/subscribed_course/screens/pdf_viewer.dart';
import 'package:etutor/features/subscribed_course/widgets/material_card.dart';
import 'package:etutor/features/subscribed_course/widgets/practice_test_card.dart';
import 'package:etutor/features/subscribed_course/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({super.key});

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  BookmarkProvider bookmarkProvider = BookmarkProvider();
  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async {
    await context.read<BookmarkProvider>().getBookMarkedContents(context: context);
  }
  @override
  Widget build(BuildContext context) {
    bookmarkProvider = context.watch<BookmarkProvider>();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: const Text(
          "Bookmarks",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.whiteColor,
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CustomBackButton(),
        ),
      ),
      body: bookmarkProvider.isLoading
      ? const Materialcardshimmer()
      : SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child:
        (bookmarkProvider.bookmarkVedio.isEmpty && bookmarkProvider.bookmarkMaterial.isEmpty)
        ? const Center(
          child: Text(
            "No bookmarked contents",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        )
        :  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             if (bookmarkProvider.bookmarkMaterial.isNotEmpty) ...[
            Text(
              "Materials",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
           ...List.generate(
            bookmarkProvider.bookmarkMaterial.length,
            (index) {
              final material = bookmarkProvider.bookmarkMaterial[index];
             
             return Dismissible(
                             key: ValueKey(material.contentid ?? index),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              onDismissed: (_) {
                                
                                context
                                    .read<BookmarkProvider>()
                                    .makeBookMark(context: context, contentid:  material.contentid  ?? "", type: 'materials');
                                    _load();
                              },
                              child: GestureDetector(
                                onTap: () {
                                    context.read<BookmarkProvider>().getMDetails(context, material.contentid ??"");
                                     final details =  bookmarkProvider.materialDetails;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PdfViewer(
                                        link: details.link ?? "",
                                        title: details.name ?? "",
                                        contentId: material.contentid ?? "",
                                      ),
                                    ),
                                  );
                                   },
                                child: MaterialCard(
                                  materialName: material.name ?? '',
                                  materialDescription: '',
                                  link: '',
                                  contentId: material.contentid ?? '',
                                ),
                              ),
                            );
            },
          ),
          const SizedBox(height: 16),
             ],
            if (bookmarkProvider.bookmarkVedio.isNotEmpty) ...[
            /// Videos Section
            Text(
              "Videos",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            ...List.generate(
            bookmarkProvider.bookmarkVedio.length,
            (index) {
              final vedio = bookmarkProvider.bookmarkVedio[index];
             
               return Dismissible(
                             key: ValueKey(vedio.contentid ?? index),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              onDismissed: (_) {
                                context
                                    .read<BookmarkProvider>()
                                    .makeBookMark(context: context, contentid: vedio.contentid ?? "videos", type: 'videos');
                                     _load();
                              },
                              child: GestureDetector(
                                onTap: (){
                                  debugPrint("start");
                                   context.read<BookmarkProvider>().getVDetails(context, vedio.contentid ??"");
                                   final details =  context.read<BookmarkProvider>().vedioDetails;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BookmarkVedioPlayer(
                                        videolink: details.link ?? "",
                                        videoTitle: details.name ?? "",
                                        videoSource: details.source ?? "",
                                        videohls: details.hls ?? "",
                                        contentId: details.videoid ?? "",
                                      ),
                                    ),
                                  );
                                },
                                child: VideoCard(
                                  title: vedio.name ?? '',
                                  img: vedio.thumbnail ?? '',
                                  duration: '',
                                ),
                              ),
                            );
            })
            ],
             const SizedBox(height: 16),
             if (bookmarkProvider.bookmarkTest.isNotEmpty) ...[
              // pratice text section
              Text(
              "Practice Test",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
           ...List.generate(
            bookmarkProvider.bookmarkTest.length,
            (index) {
              final test = bookmarkProvider.bookmarkTest[index];
             return Dismissible(
                             key: ValueKey(test.contentid ?? index),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              onDismissed: (_) {
                                context
                                    .read<BookmarkProvider>()
                                    .makeBookMark(context: context, contentid:  test.contentid  ?? "", type: 'practice');
                                    _load();
                              },
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (_) => QuizInstructionPage(
                                  //       duration: '', 
                                  //       questions: '', 
                                  //       testName: test.name ?? '', 
                                  //       testid: test.id ?? '')
                                  //   ),
                                  // );
                                   },
                                child:  PracticeTestCard(
                                  testName: test.name ?? '', 
                                  testDuration: '', 
                                  // questions: '', 
                                  // testId: test.id ?? '', 
                                  isAttended: false,
                                ),
                              ),
                            );
            },
          ),
           ]
          ],
        ),
      ),
    );
  }
}


class Materialcardshimmer extends StatelessWidget {
  const Materialcardshimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 120,
            height: 20,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Leading Icon Placeholder
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title Placeholder
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: double.infinity,
                            height: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Description Placeholder
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: 150,
                            height: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Arrow Placeholder
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 15,
                    height: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
