import 'dart:io';

import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:etutor/features/auth/models/drop_down_option_model.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/home/provider/user_details_provider.dart';
import 'package:etutor/features/profile/widgets/u_shaped_painter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}


class _EditProfileState extends State<EditProfile> {
  File? _image;
  final picker = ImagePicker();
  List<Classes> _class = [];
  List<Syllabus> _syllabus = [];

  String? selectedClass;
  String? selectedSyllabus;


  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController syllabusController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  

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
  void initState() {
    super.initState();
    // final userDetails =
    //    context.watch<UserDetailsProvider>().userDetails.data;
    //   firstnameController.text = userDetails!.firstName!;
    // _class = context.watch<LoginProvider>().classes;
    // _syllabus = context.watch<LoginProvider>().syllabus;
    final userDetails = context.read<UserDetailsProvider>().userDetails.data!;
    firstnameController.text = userDetails.firstName!;
    lastnameController.text = userDetails.lastName!;
    emailController.text = userDetails.email!;
    schoolController.text = userDetails.school!;
  }



  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
     // print('No image selected.');
    }
  }
  
  @override
  Widget build(BuildContext context) {
     final userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails.data;
           _class = context.watch<LoginProvider>().classes;
          _syllabus = context.watch<LoginProvider>().syllabus;
      // _class =   Provider.of<LoginProvider>(context).classes ;
      //  _syllabus =   Provider.of<LoginProvider>(context).syllabus ;
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
                        child: _image == null
                         ?  Image.asset(
                          "assets/images/basil.jpg",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                        : Image.file(_image!,
                         width: 100,
                          height: 100,
                          fit: BoxFit.cover,),
                        
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height:30,
                              //margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: AppColor.greyCardBackground,
                                  borderRadius: BorderRadius.circular(30),
                                  border:
                                      Border.all(color: AppColor.greyStroke)),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: IconButton(
                                  onPressed:  () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) => _buildImagePickerDialog(context),
                                    );
                                  },
                                  icon: Icon(Icons.edit,size: 15,
                                  color: AppColor.greyIconDark,),
                                  
                                ),
                              )))
                    ]),
                    SizedBox(
                      height: 30,
                    ),
                    GreystokeTextfield(
                        controller: firstnameController, text:" First Name"),
                    SizedBox(
                      height: 15,
                    ),
                    GreystokeTextfield(
                        controller: lastnameController, text: "Last Name"),
                    SizedBox(
                      height: 15,
                    ),
                    GreystokeTextfield(
                        controller: emailController, text: "Email"),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child:
                                dropdown(
                                  "Class",
                                 _class
                                  .map((classmodel) => classmodel.name ?? "")
                                  .toList(),
                                  userDetails?.qualification
                                )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: dropdown(
                                "Syllabus", 
                                _syllabus
                                  .map((syllabusmodel) =>
                                      syllabusmodel.name ?? "")
                                  .toList(),
                                  userDetails?.syllabus
                                )),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GreystokeTextfield(controller: schoolController, text: userDetails?.school ?? ""),
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

// dialog box for imagepicker
Widget _buildImagePickerDialog(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          Text("Choose an option", style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FloatingActionButton.extended(
                  backgroundColor: AppColor.greyButton,
                  heroTag: "gallery",
                  onPressed: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                  icon: Icon(Icons.photo),
                  label: Text("Gallery"),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: FloatingActionButton.extended(
                  backgroundColor: AppColor.greyButton,
                  heroTag: "camera",
                  onPressed: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text("Camera"),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

  //dropdown
  DropdownButtonFormField<String> dropdown(
      String text,
      List<String> item, 
      String? dropdownValue,
    //  Function(String?) onChanged,
      ) {
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
class GreystokeTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  const GreystokeTextfield({
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
