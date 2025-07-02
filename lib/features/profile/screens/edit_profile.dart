import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:etutor/features/profile/widgets/u_shaped_painter.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? classDropdownValue = "class 6";
  String? syllabusDropdownValue = "Kerala State";
  final List<String> _class = [
    "class 5",
    "class 6",
    "class 7",
    "class 8",
    "class 9",
    "class 10",
    "class 11",
    "class 12",
    "Others"
  ];
  final List<String> _syllabus = [
    "Kerala State",
    "CBSE",
    "ICSE",
  ];
  final TextEditingController firstnameController =
      TextEditingController(text: "Basil");
  final TextEditingController lastnameController =
      TextEditingController(text: "Joseph");
  final TextEditingController emailController =
      TextEditingController(text: "josephbasil@gmail.com");
  final TextEditingController classController =
      TextEditingController(text: "class 6");
  final TextEditingController syllabusController =
      TextEditingController(text: "Kerala State");
  final TextEditingController schoolController =
      TextEditingController(text: "Kerala State");

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    classController.dispose();
    syllabusController.dispose();
    emailController.dispose();
    schoolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(color: AppColor.whiteColor, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CustomPaint(
              painter: UShapedPainter(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 120,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "assets/images/basil.jpg",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: AppColor.greyCardBackground,
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(color: AppColor.greyStroke)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: AppColor.greyIconDark,
                                ),
                              )))
                    ]),
                    SizedBox(
                      height: 30,
                    ),
                    greystokeTextfield(
                        controller: firstnameController, text: "First Name"),
                    SizedBox(
                      height: 15,
                    ),
                    greystokeTextfield(
                        controller: lastnameController, text: "last Name"),
                    SizedBox(
                      height: 15,
                    ),
                    greystokeTextfield(
                        controller: emailController, text: "Email"),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child:
                                dropdown("Class", _class, classDropdownValue)),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: dropdown(
                                "Syllabus", _syllabus, syllabusDropdownValue)),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    greystokeTextfield(
                        controller: schoolController, text: "school"),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomButton(
                          buttoncolor: AppColor.greyButton,
                          onpressed: () {
                           Navigator.pop(context);
                          },
                          text: 'Cancel',
                          textColor: AppColor.greyTextDark,
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: CustomButton(
                          buttoncolor: AppColor.primaryColor,
                          onpressed: () {
                           Navigator.pop(context);
                          },
                          text: 'Update',
                          textColor: AppColor.whiteColor,
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //dropdown
  DropdownButtonFormField<String> dropdown(
      String text, List<String> item, String? dropdownValue) {
    return DropdownButtonFormField<String>(
      icon: Icon(Icons.keyboard_arrow_down_outlined, color: AppColor.greyText),
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      dropdownColor: AppColor.greyBackground,
      decoration: InputDecoration(
        labelText: text,
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
      ),
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: item.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,
              style: TextStyle(color: Colors.black, fontFamily: 'Poppins')),
        );
      }).toList(),
    );
  }
}

// custom textformfield with greystroke
class greystokeTextfield extends StatelessWidget {
  TextEditingController controller;
  String text;
  greystokeTextfield({
    super.key,
    required this.controller,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: text,
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
      ),
    );
  }
}
