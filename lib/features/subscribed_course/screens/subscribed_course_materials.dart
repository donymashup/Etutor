import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/provider/chapter_card_overview_provider.dart';
import 'package:etutor/features/subscribed_course/widgets/listview_shimmer_loader.dart';
import 'package:etutor/features/subscribed_course/widgets/material_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscribedCourseMaterials extends StatefulWidget {
final String packageChapterId;

const SubscribedCourseMaterials({
  super.key,
  required this.packageChapterId,
  });

  @override
  State<SubscribedCourseMaterials> createState() =>
      _SubscribedCourseMaterialsState();
}

class _SubscribedCourseMaterialsState extends State<SubscribedCourseMaterials> {
 ChapterCardOverviewProvider chaptercardProvider = ChapterCardOverviewProvider();

 @override
  void initState() {
    super.initState();
    _loadMaterials();

  }

  Future <void> _loadMaterials()async{
    await context.read<ChapterCardOverviewProvider>().fetchChapterMaterial(context, widget.packageChapterId);
  } 

  @override
  Widget build(BuildContext context) {
    chaptercardProvider = context.watch<ChapterCardOverviewProvider>();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: Text(
          "Materials",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
      ),
      body: chaptercardProvider.isMaterialLoading 
      ? ListviewShimmerLoader()
      :SafeArea( 
        child: chaptercardProvider.chapterMaterial.isEmpty   
              ? Center(child: Text("No Materials"),)
              :Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
               Expanded(
                child: ListView.builder(
                  itemCount: chaptercardProvider.chapterMaterial.length,
                  itemBuilder: (context, index)  
                  {
                    final materials = chaptercardProvider.chapterMaterial[index];
                    return GestureDetector(
                    child: MaterialCard(
                     materialName: materials.name ?? '', 
                     materialDescription: materials.description ?? '', 
                    // packageChapterId: widget.packageChapterId,
                     link: materials.link ?? '', 
                     contentId: materials.id ?? '',
                    ),
                  );}
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
