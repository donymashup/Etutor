import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String? classDropdownValue;
  String? syllabusDropdownValue;
  bool isChecked = false;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: AppColor.primaryColor,
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 50,
                            width: 100,
                            alignment: Alignment.center,
                          ),
                        ),
                        
                        CustomBackButton(),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Create Your Account",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    Text(
                      "Looks like you’re new here. Complete your\n registration to begin learning",
                      style: TextStyle(color: AppColor.whiteColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  //first name
                  label(labelText: "First Name",),
                  SizedBox(height: 5,),
                  greystokeTextfield(
                    hintText: "First Name",
                    iconData: Icons.person_outline_rounded,
                  ),
                  SizedBox(height: 10,),

                  // last name
                  label(labelText: "Last Name",),
                  SizedBox(height: 5,),
                  greystokeTextfield(
                    hintText: "Last Name",
                    iconData: Icons.person_outline_rounded,
                  ),
                  SizedBox(height: 10,),

                  //email
                  label(labelText: "Email", ),
                  SizedBox( height: 5, ),
                  greystokeTextfield(
                    hintText: "Email",
                    iconData: Icons.email_outlined,
                  ),
                  SizedBox( height: 10,),

                  //phone number
                  label( labelText: "Phone Number",),
                  SizedBox(height: 5,),
                  greystokeTextfield(
                    hintText: "Phone Number",
                    iconData: Icons.email_outlined,
                  ),
                  SizedBox( height: 10, ),

                  //class
                  label(labelText: "Class",),
                  SizedBox( height: 5,),
                  dropdown(Icons.school_outlined, "Class", _class,classDropdownValue),
                  SizedBox(  height: 10,),

                  //syllabus
                  label(labelText: "Syllabus",),
                  SizedBox(height: 5,),
                  dropdown(Icons.description_outlined, "Syllabus", _syllabus, syllabusDropdownValue),
                  SizedBox( height: 10,),

                  //school
                  label(labelText: "School",),
                  SizedBox(height: 5,),
                  greystokeTextfield(
                    hintText: "School",
                    iconData: Icons.business_outlined,
                  ),
                  SizedBox(height: 10,),

                  //password
                  label( labelText: "Password",),
                  SizedBox( height: 5,),
                  greystokeTextfield(
                    hintText: "Password",
                    iconData: Icons.lock_outline_rounded,
                    isPassword: true,
                  ),
                  SizedBox(height: 10,),

                  //confirm password
                  label( labelText: "Confirm Password",),
                  SizedBox( height: 5,),
                  greystokeTextfield(
                    hintText: "Confirm Password",
                    iconData: Icons.lock_outline_rounded,
                    isPassword: true,
                  ),
                  SizedBox(  height: 20, ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        activeColor:  AppColor.primaryColor,
                        value: isChecked, 
                        onChanged: (bool? value){
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                       ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(fontFamily: "Poppins"),
                           children: [
                            TextSpan(text: "By Signing up, you accept with out ",style: TextStyle(color: AppColor.greyText)),
                            TextSpan(text: "Terms of Service ",style: TextStyle(color: AppColor.primaryColor,fontWeight: FontWeight.w500)),
                            TextSpan(text: "and ",style: TextStyle(color: AppColor.greyText)),
                            TextSpan(text: "Privacy Policy",style: TextStyle(color: AppColor.primaryColor,fontWeight: FontWeight.w500)),
                           ]
                        )),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  
                  CustomButton(
                    onpressed: () {},
                    text: "Get Started",
                    buttoncolor:AppColor.primaryColor,textColor: AppColor.whiteColor,)                                   
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//method for dropdown
  DropdownButtonFormField<String> dropdown(IconData iconData, String hint,
      List<String> item, String? dropdownValue) {
    return DropdownButtonFormField<String>(
      icon: Icon(Icons.keyboard_arrow_down_outlined,color: AppColor.greyText),
      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18,),
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
          iconData,
          color: AppColor.greyIcon,
          size: 18,
        ),
      ),
      hint: Text(
        hint,
        style: TextStyle(color: AppColor.greyText, fontWeight: FontWeight.w400),
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
          style: TextStyle(color: Colors.black,fontFamily: 'Poppins')),
        );
      }).toList(),
    );
  }
}


//widget for lable of the textfield
class label extends StatelessWidget {
  String labelText;
  label({
    super.key,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "*",
          style: TextStyle(color: Colors.red),
        ),
        SizedBox(
          width: 5,
        ),
        Text(labelText),
      ],
    );
  }
}

// custom textformfield with greystroke
class greystokeTextfield extends StatelessWidget {
  String hintText;
  IconData iconData;
  bool isPassword;
  greystokeTextfield({
    super.key,
    required this.hintText,
    required this.iconData,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword ? true : false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColor.greyText),
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
          iconData,
          color: AppColor.greyIcon,
          size: 18,
        ),
        suffixIcon: isPassword
            ? Icon(
                Icons.visibility_off_outlined,
                color: AppColor.greyIcon,
                size: 18,
              )
            : null,
      ),
    );
  }
}
