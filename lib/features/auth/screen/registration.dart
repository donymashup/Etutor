import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_back_ios_new_outlined,
                                color: AppColor.whiteColor),
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 50,
                            width: 100,
                            alignment: Alignment.center,
                          ),
                        ),
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
                  label(
                    labelText: "First Name",
                  ),
                  SizedBox(height: 5,),
                  greystokeTextfield(
                    hintText: "First Name",
                    iconData: Icons.person_outline_rounded,
                  ),
                  SizedBox(height: 10,),
                  // last name
                  label(
                    labelText: "Last Name",
                  ),
                  SizedBox(height: 5,),
                  greystokeTextfield(
                    hintText: "Last Name",
                    iconData: Icons.person_outline_rounded,
                  ),
                  SizedBox(height: 10,),
                  //email
                  label(
                    labelText: "Email",
                  ),
                  SizedBox(height: 5,),
                  greystokeTextfield(
                    hintText: "Email",
                    iconData: Icons.email_outlined,
                  ),
                  SizedBox(height: 10,),
                  //phone number
                  label(
                    labelText: "Phone Number",
                  ),
                  SizedBox(height: 5,),
                  greystokeTextfield(
                    hintText: "Phone Number",
                    iconData: Icons.email_outlined,
                  ),
                  SizedBox(height: 10,),
                  //class
        //            DropdownButtonFormField<String>(
        //   decoration: InputDecoration(
        //     labelText: 'Select a fruit',
        //     border: OutlineInputBorder(),
        //   ),
        //   value: _selectedFruit,
        //   items: _fruits.map((fruit) {
        //     return DropdownMenuItem(
        //       value: fruit,
        //       child: Text(fruit),
        //     );
        //   }).toList(),
        //   onChanged: (value) {
        //     setState(() {
        //       _selectedFruit = value;
        //     });
        //   },
        // ),
                  //syllabus

                  //school
                  label(
                    labelText: "School",
                  ),
                  SizedBox(height: 5,),
                  greystokeTextfield(
                    hintText: "School",
                    iconData: Icons.school_outlined,
                  ),
                  SizedBox(height: 10,),
                  //password
                  label(
                    labelText: "Password",
                  ),
                  SizedBox(height: 5,),
                  greystokeTextfield(
                    hintText: "Password",
                    iconData: Icons.lock_outline_rounded,
                  ),
                  SizedBox(height: 10,),
                  //confirm password
                  label(
                    labelText: "Confirm Password",
                  ),
                  SizedBox(height: 5,),
                  greystokeTextfield(
                    hintText: "Confirm Password",
                    iconData: Icons.lock_outline_rounded,
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class greystokeTextfield extends StatelessWidget {
  String hintText;
  IconData iconData;
  greystokeTextfield({
    super.key,
    required this.hintText,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          prefixIcon: Icon(iconData,color: AppColor.greyIcon,size: 18,),
      ),
    );
  }
}
