import 'package:cached_network_image/cached_network_image.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/subscribed_course/widgets/course_chapter_card.dart';
import 'package:etutor/features/subscribed_course/widgets/listview_shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SubscribedCourseChapters extends StatefulWidget {
final  String subjectName;
final  String subjectImage;
final  String packageSubjectId;
const  SubscribedCourseChapters({
    super.key, 
    required this.subjectImage, 
    required this.subjectName,
    required this.packageSubjectId});

  @override

  State<SubscribedCourseChapters> createState() => _SubscribedCourseSubjectState();
}
class _SubscribedCourseSubjectState extends State<SubscribedCourseChapters> {
  SubcribedCourseProvider subcribedCourseProvider = SubcribedCourseProvider();
   
  @override
  void initState() {
    super.initState();
     _loadChapter();
  }   

  Future<void> _loadChapter()async{
      await context.read<SubcribedCourseProvider>().fetchCourseChapter(context,widget.packageSubjectId);
  }

  @override
  Widget build(BuildContext context) {
    subcribedCourseProvider = context.watch<SubcribedCourseProvider>();
    final expandedIndex = subcribedCourseProvider.expandedIndex;
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body :  SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child:  CachedNetworkImage(
                        imageUrl: widget.subjectImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(color: Colors.grey.shade300),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.broken_image, size: 40),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CustomBackButton(),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Text(
                    widget.subjectName,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                  ),
                ),
              ],
            ),
            Expanded(
              child: subcribedCourseProvider.isLoadingchapter
              ? ListviewShimmerLoader()
              :subcribedCourseProvider.courseChapter.isEmpty 
              ? Center(child: Text("No Chapters"),)
              :Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ListView.builder(
                itemCount: subcribedCourseProvider.courseChapter.length,
                itemBuilder: (context, index) {
                  final chapter = subcribedCourseProvider.courseChapter[index];
                  return CourseChapterCard(
                    subjectName: chapter!.chaptersName?? '',
                    subjectImage: chapter.chaptersImage?? '',
                    packageChapterId: chapter.packageChapterId ?? '',
                     isExpanded: expandedIndex == index,
                      onTap: () {
                        subcribedCourseProvider.toggleExpansion(index);
                      },
                  );
                 }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
