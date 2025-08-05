import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_all_subjects.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_content.dart';
import 'package:etutor/features/subscribed_course/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SubscribedCourseOverview extends StatefulWidget {
  const SubscribedCourseOverview({super.key});

  @override
  State<SubscribedCourseOverview> createState() =>
      _SubscribedCourseOverviewState();
}

class CourseOverview {
  String title;
  String subtitle;
  String type;
  void Function() onPressed;

  CourseOverview({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.onPressed,
  });
}

class _SubscribedCourseOverviewState extends State<SubscribedCourseOverview> {
  late List<CourseOverview> courseoverview;

  @override
  void initState() {
    super.initState();

    courseoverview = [
      CourseOverview(
        title: "Class 6",
        subtitle: "Class 6 subjects",
        type: "class",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubscribedCourseAllSubjects(),
            ),
          );
        },
      ),
      CourseOverview(
        title: "Class 7",
        subtitle: "Class 7 subjects",
        type: "class",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubscribedCourseAllSubjects(),
            ),
          );
        },
      ),
      CourseOverview(
        title: "Course Contents",
        subtitle: "Tap to view all other resources related to this course",
        type: "folder",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubscribedCourseContent(),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/oly1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomBackButton(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 260),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "International Social Studies Olympiad",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: ListView.builder(
                      itemCount: courseoverview.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: courseoverview[index].onPressed,
                        child: CourseCard(
                          title: courseoverview[index].title,
                          subtitle: courseoverview[index].subtitle,
                          type: courseoverview[index].type,
                          onPressed: courseoverview[index].onPressed,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FloatingActionButton(
                        backgroundColor: AppColor.secondaryColor,
                        onPressed: () {
                          showRatingDialog(context);
                        },
                        child: const Icon(Icons.star, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showRatingDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      int selectedRating = 0;
      List<String> feedbackTags = [];
      TextEditingController suggestionController = TextEditingController();

      List<String> issues = [
        "Term Life",
        "Health",
        "Investment",
        "Car",
        "Two Wheeler",
        "To many calls",
        "Customer Care",
        "Incorrect Policy",
        "Policy Issue",
        "Slow App"
      ];

      String getRatingText(int rating) {
        switch (rating) {
          case 1:
            return "Very Bad";
          case 2:
            return "Bad";
          case 3:
            return "Okay";
          case 4:
            return "Good";
          case 5:
            return "Excellent";
          default:
            return "";
        }
      }

      return StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: Lottie.asset('assets/lottie/ratinglottie.json'),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    selectedRating == 5
                        ? "Excellent!"
                        : "Rate your experience with us!",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          size: 32,
                          color: index < selectedRating
                              ? Colors.orange
                              : Colors.grey.shade400,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedRating = index + 1;
                          });
                        },
                      );
                    }),
                  ),
                  if (selectedRating > 0)
                    Text(
                      getRatingText(selectedRating),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  const SizedBox(height: 16),
                  if (selectedRating < 5 && selectedRating > 0) ...[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Where can we improve?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: issues.map((issue) {
                        final selected = feedbackTags.contains(issue);
                        return ChoiceChip(
                          label: Text(issue),
                          selected: selected,
                          onSelected: (_) {
                            setState(() {
                              if (selected) {
                                feedbackTags.remove(issue);
                              } else {
                                feedbackTags.add(issue);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: suggestionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: "Any other suggestions?",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                  if (selectedRating == 5)
                    Column(
                      children: [
                        const Text(
                          "Thanks for loving us!",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Spread the word by rating us on PlayStore",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.secondaryColor,
                          ),
                          child: const Text("Rate Us"),
                        ),
                      ],
                    )
                  else
                    ElevatedButton(
                      onPressed: selectedRating == 0
                          ? null
                          : () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Thanks for your feedback (${selectedRating}★)"),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.secondaryColor,
                      ),
                      child: const Text("Submit"),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
