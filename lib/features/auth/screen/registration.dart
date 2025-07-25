import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  DateTime? selectedDate;

  String? phoneNumber;
  String? classDropdownValue;
  String? syllabusDropdownValue;
  String? selectedGender;
  bool isChecked = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
  void dispose() {
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                            "assets/images/logo_without_bg.png",
                            height: 50,
                            width: 100,
                          ),
                        ),
                        CustomBackButton(),
                      ],
                    ),
                    const SizedBox(height: 20),
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Label(labelText: "First Name"),
                    const SizedBox(height: 5),
                    GreystokeTextfield(
                      hintText: "First Name",
                      iconData: Icons.person_outline_rounded,
                      controller: firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Label(labelText: "Last Name"),
                    const SizedBox(height: 5),
                    GreystokeTextfield(
                      hintText: "Last Name",
                      iconData: Icons.person_outline_rounded,
                      controller: lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Label(labelText: "Gender"),
                    const SizedBox(height: 5),
                    FormField<String>(
                      validator: (value) {
                        if (selectedGender == null) {
                          return 'Please select a gender';
                        }
                        return null;
                      },
                      builder: (formFieldState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children:
                                  ['Male', 'Female', 'Other'].map((gender) {
                                return Row(
                                  children: [
                                    Radio<String>(
                                      value: gender,
                                      groupValue: selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGender = value;
                                          formFieldState.didChange(value);
                                        });
                                      },
                                    ),
                                    Text(
                                      gender,
                                      style: TextStyle(
                                        color: selectedGender == gender
                                            ? AppColor.blackColor
                                            : AppColor.greyText,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                );
                              }).toList(),
                            ),
                            if (formFieldState.hasError)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 4),
                                child: Text(
                                  formFieldState.errorText!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Label(labelText: "Date of Birth"),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: AppColor.primaryColor,
                                  onPrimary: Colors.white,
                                  onSurface: AppColor.primaryColor,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                            dobController.text =
                                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: GreystokeTextfield(
                          hintText: "Select your date of birth",
                          iconData: Icons.calendar_today,
                          controller: dobController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your date of birth';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Label(labelText: "Email"),
                    const SizedBox(height: 5),
                    GreystokeTextfield(
                      hintText: "Email",
                      iconData: Icons.email_outlined,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Enter valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Label(labelText: "Phone Number"),
                    const SizedBox(height: 5),
                    IntlPhoneField(
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(color: AppColor.greyText),
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
                          Icons.phone_android_outlined,
                          color: AppColor.greyIcon,
                          size: 18,
                        ),
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        phoneNumber = phone.completeNumber;
                      },
                      validator: (phone) {
                        if (phone == null || phone.number.isEmpty) {
                          return 'Enter phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Label(labelText: "Class"),
                    const SizedBox(height: 5),
                    dropdown(Icons.school_outlined, "Class", _class,
                        classDropdownValue, (value) {
                      classDropdownValue = value;
                    }),
                    const SizedBox(height: 10),
                    Label(labelText: "Syllabus"),
                    const SizedBox(height: 5),
                    dropdown(Icons.description_outlined, "Syllabus", _syllabus,
                        syllabusDropdownValue, (value) {
                      syllabusDropdownValue = value;
                    }),
                    const SizedBox(height: 10),
                    Label(labelText: "School"),
                    const SizedBox(height: 5),
                    GreystokeTextfield(
                      hintText: "School",
                      iconData: Icons.business_outlined,
                      controller: schoolController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter school name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Label(labelText: "Password"),
                    const SizedBox(height: 5),
                    TextFormField(
                      obscureText: _obscurePassword,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(color: AppColor.greyText),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: AppColor.greyStroke, width: 1.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: AppColor.greyStroke, width: 1.0),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        prefixIcon: Icon(Icons.lock_outline_rounded,
                            color: AppColor.greyIcon, size: 18),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColor.greyIcon,
                            size: 18,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Label(labelText: "Confirm Password"),
                    const SizedBox(height: 5),
                    TextFormField(
                      obscureText: _obscureConfirmPassword,
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value != passwordController.text ||
                            value!.isEmpty) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(color: AppColor.greyText),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: AppColor.greyStroke, width: 1.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: AppColor.greyStroke, width: 1.0),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        prefixIcon: Icon(Icons.lock_outline_rounded,
                            color: AppColor.greyIcon, size: 18),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColor.greyIcon,
                            size: 18,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: AppColor.primaryColor,
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(fontFamily: "Poppins"),
                              children: [
                                TextSpan(
                                  text: "By Signing up, you accept our ",
                                  style: TextStyle(color: AppColor.greyText),
                                ),
                                TextSpan(
                                  text: "Terms of Service ",
                                  style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: "and ",
                                  style: TextStyle(color: AppColor.greyText),
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                      onpressed: () {
                        if (_formKey.currentState!.validate() &&
                            isChecked &&
                            classDropdownValue != null &&
                            syllabusDropdownValue != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBarScreen()),
                          );
                        } else if (!isChecked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please accept Terms and Conditions to continue'),
                            ),
                          );
                        } else if (classDropdownValue == null ||
                            syllabusDropdownValue == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select class and syllabus'),
                            ),
                          );
                        }
                      },
                      text: "Get Started",
                      buttoncolor: AppColor.primaryColor,
                      textColor: AppColor.whiteColor,
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

  // Dropdown widget with validation
  DropdownButtonFormField<String> dropdown(
    IconData iconData,
    String hint,
    List<String> item,
    String? dropdownValue,
    Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      icon: Icon(Icons.keyboard_arrow_down_outlined, color: AppColor.greyText),
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18,color:AppColor.blackColor),
      dropdownColor: AppColor.greyBackground,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.greyStroke, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.greyStroke, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        prefixIcon: Icon(iconData, color: AppColor.greyIcon, size: 18),
      ),
      hint: Text(hint,
          style:
              TextStyle(color: AppColor.greyText, fontWeight: FontWeight.w400)),
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          onChanged(newValue);
        });
      },
      validator: (value) => value == null ? 'Please select $hint' : null,
      items: item.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(fontFamily: 'Poppins')),
        );
      }).toList(),
    );
  }
}

//widget for lable of the textfield
class Label extends StatelessWidget {
  final String labelText;
  const Label({
    super.key,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("*", style: TextStyle(color: Colors.red)),
        const SizedBox(width: 5),
        Text(labelText),
      ],
    );
  }
}

// custom textformfield with greystroke
class GreystokeTextfield extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const GreystokeTextfield({
    super.key,
    required this.hintText,
    required this.iconData,
    required this.controller,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColor.greyText),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.greyStroke, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.greyStroke, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        prefixIcon: Icon(iconData, color: AppColor.greyIcon, size: 18),
        suffixIcon: isPassword
            ? Icon(Icons.visibility_off_outlined,
                color: AppColor.greyIcon, size: 18)
            : null,
      ),
    );
  }
}
