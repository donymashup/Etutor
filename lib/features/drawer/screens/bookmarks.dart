import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/provider/bookmark_provider.dart';
import 'package:etutor/features/subscribed_course/widgets/material_card.dart';
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
    context.read<BookmarkProvider>().getBookMarkedContents(context: context);
    super.initState();
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
        child: (bookmarkProvider.bookmarkVedio.isEmpty && bookmarkProvider.bookmarkMaterial.isEmpty)
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
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             if (bookmarkProvider.bookmarkVedio.isNotEmpty) ...[
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
              return MaterialCard(
                materialName: material.name, 
                materialDescription:'', 
                link: '', 
                contentId:material.id,        
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
              return VideoCard(
              title: vedio.name,
              img: vedio.thumbnail,
              duration: '',
            );
            })
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
