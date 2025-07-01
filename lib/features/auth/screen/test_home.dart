import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_subject.dart';
import 'package:etutor/features/subscribed_course/widgets/course_subject_card.dart';
import 'package:etutor/features/subscribed_course/widgets/subject_overview_card.dart';
import 'package:flutter/material.dart';

class TestHome extends StatelessWidget {
  TestHome({super.key});

  List<Subject> subject = [
    Subject(
        subjectName: "SEPERATION OF SUBSTANCES",
        subjectImage: 'assets/images/subname1.jpg'),
    Subject(
        subjectName: "SORTING MATERIALS",
        subjectImage: 'assets/images/subname2.jpg'),
    Subject(
        subjectName: "FIBRE TO FABRIC",
        subjectImage: 'assets/images/subname3.jpg'),
    Subject(
        subjectName: "COMPONENTS OF FOOD",
        subjectImage: 'assets/images/subname4.jpg'),
        Subject(
        subjectName: "SEPERATION OF SUBSTANCES",
        subjectImage: 'assets/images/subname1.jpg'),
    Subject(
        subjectName: "SORTING MATERIALS",
        subjectImage: 'assets/images/subname2.jpg'),
    Subject(
        subjectName: "FIBRE TO FABRIC",
        subjectImage: 'assets/images/subname3.jpg'),
    Subject(
        subjectName: "COMPONENTS OF FOOD",
        subjectImage: 'assets/images/subname4.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        // appBar: AppBar(backgroundColor: AppColor.primaryColor,),
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 250.0,
                automaticallyImplyLeading: false,
                // floating: false,
                foregroundColor: AppColor.whiteColor,
                // pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("Science",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 25, color: AppColor.whiteColor)),
                  ),
                  background: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/subname1.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.5,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color.fromARGB(255, 0, 0, 0),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    // return CourseSubjectCard(
                    //     subjectName: subject[index].subjectName,
                    //     subjectImage: subject[index].subjectImage,
                    //     onPressed: () {}
                    //     );
                  },
                  childCount: subject.length,
                ),
              ),
              
              SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
    );
  }
}


 Widget _iconWithLabel(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }

