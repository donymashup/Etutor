import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/my_course/widgets/mycoursecard.dart';
import 'package:flutter/material.dart';

class SeeMoreCourses extends StatefulWidget {
  const SeeMoreCourses({super.key});

  @override
  State<SeeMoreCourses> createState() => _SeeMoreCoursesState();
}

class _SeeMoreCoursesState extends State<SeeMoreCourses> {
  String? classDropdownValue;
  List<Map<String, dynamic>> filteredclass = [];
  final List<String> _class = [
    "class 5",
    "class 6",
    "class 7",
    "class 8",
    "class 9",
    "class 10",
    "class 11",
    "class 12",
    "All Courses"
  ];
  final List<Map<String, dynamic>> courses = const [
    {
      'title': ' International General Knowledge Olympiad (IGKO)',
      'image': 'assets/images/oly2.jpg',
      'isFree': false,
      'rating': 4.6,
      'class': 'class 6',
    },
    {
      'title': 'International Commerce Olympiad (ICO)',
      'image': 'assets/images/oly3.jpeg',
      'isFree': false,
      'rating': 4.4,
      'class': 'class 6',
    },
    {
      'title': 'International English Olympiad (IEO)',
      'image': 'assets/images/oly4.jpg',
      'isFree': false,
      'rating': 4.7,
      'class': 'class 7',
    },
    {
      'title': 'Mental Ability 25-26',
      'image': 'assets/images/oly8.jpg',
      'isFree': true,
      'rating': 4.8,
      'class': 'class 6',
    },
    {
      'title': ' International Hindi Olympiad (IEO)',
      'image': 'assets/images/oly11.jpg',
      'isFree': false,
      'rating': 4.3,
      'class': 'class 10',
    },
    {
      'title': 'International Social Studies Olympiad (ISSO)',
      'image': 'assets/images/oly1.jpg',
      'isFree': false,
      'rating': 4.5,
      'class': 'class 8',
    },
    {
      'title': 'Math Olympiad 25-26',
      'image': 'assets/images/oly9.jpg',
      'rating': 4.6,
      'isFree': true,
      'class': 'class 9',
    },
    {
      'title': 'Spell Bee (CSB) ',
      'image': 'assets/images/oly10.jpg',
      'rating': 4.9,
      'isFree': false,
      'class': 'class 7',
    },
    {
      'title': 'National Interactive Maths Olympiad [NIMO]',
      'image': 'assets/images/oly6.jpeg',
      'isFree': true,
      'rating': 4.9,
      'class': 'class 8',
    },
    {
      'title': 'International Mathematics Olympiad (IMO)',
      'image': 'assets/images/oly5.webp',
      'isFree': false,
      'rating': 4.8,
      'class': 'class 9',
    },
    {
      'image': 'assets/images/oly7.png',
      'title': 'National Science Olympiad (NSO)',
      'isFree': true,
      'rating': 4.6,
      'class': 'class 10',
    },
    {
      'title': 'English Smart Series',
      'image': 'assets/images/oly6.jpeg',
      'isFree': true,
      'rating': 4.3,
      'class': 'class 7',
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredclass = courses;
  }

void _filterByclass(String query) {
    if (query.isEmpty || query.toLowerCase() == "all courses") {
      setState(() {
        filteredclass =courses; 
      });
    }else {
      setState(() {
        filteredclass = courses.where((item) {
          return item['class']!
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CustomBackButton(),
            ),
            SizedBox(
              width: 10,
            ),
            Text("All Courses"),
          ],
        ),
      ),  
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField(
                icon: Icon(Icons.keyboard_arrow_down_outlined,
                    color: AppColor.greyText),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                dropdownColor: AppColor.greyBackground,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: AppColor.greyStroke,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: AppColor.greyStroke,
                      width: 1.0,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.filter_alt_outlined,
                    color: AppColor.greyIcon,
                    size: 18,
                  ),
                ),
                hint: Text(
                  "Filter by Class",
                  style: TextStyle(
                      color: AppColor.greyText, fontWeight: FontWeight.w400),
                ),
                value: classDropdownValue,
                items: _class.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Poppins')),
                  );
                }).toList(),
                  onChanged: (String? newValue) {
                   _filterByclass(newValue!);
                  setState(() {
                    classDropdownValue = newValue;
                   
                  });
                },
              ),
            ),
            filteredclass.isEmpty ? Center(child: Text("No Matching results found")):
            Wrap(
              spacing: 10,
              alignment: WrapAlignment.start,
              children: [
                ...List.generate(
                    filteredclass.length,
                    (index) => MyCourseCard(
                          title: filteredclass[index]['title'],
                          imagePath: filteredclass[index]['image'],
                          rating: filteredclass[index]['rating'],
                          isFree: filteredclass[index]['isFree'],
                        ))
              ],
            ),
          ],
        ),
      )),
    );
  }
}
