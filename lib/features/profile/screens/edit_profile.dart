import 'dart:io';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:etutor/features/auth/models/drop_down_option_model.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/auth/widgets/label_widget.dart';
import 'package:etutor/features/home/provider/user_details_provider.dart';
import 'package:etutor/features/profile/widgets/u_shaped_painter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  File? _image;
  final picker = ImagePicker();
  List<Classes> _class = [];
  List<Syllabus> _syllabus = [];
  String? selectedClass;
  String? selectedSyllabus;
  String? codeController;
  String? _profileImageUrl;
  DateTime? selectedDate;
  String? _selectedGender;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    schoolController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final loginProvider = context.read<LoginProvider>();
    loginProvider.dropDownOptions(context);

    final userDetails = context.read<UserDetailsProvider>().userDetails.data!;
    firstnameController.text = userDetails.firstName ?? '';
    lastnameController.text = userDetails.lastName ?? '';
    emailController.text = userDetails.email ?? '';
    schoolController.text = userDetails.school ?? '';
    codeController = userDetails.country ?? '';
    phoneController.text = userDetails.phone ?? '';
    _selectedGender =
        userDetails.gender?.toLowerCase().replaceAll(RegExp(r'\s+'), '');


    // Parse and set DOB text + selectedDate if available
    if (userDetails.dob != null && userDetails.dob!.isNotEmpty) {
      try {
        selectedDate = DateTime.parse(userDetails.dob!);
        dobController.text =
            "${selectedDate!.day.toString().padLeft(2, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.year}";
      } catch (e) {
        dobController.text = '';
      }
    }
    _profileImageUrl = userDetails.image;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // Upload image via provider
      await Provider.of<UserDetailsProvider>(context, listen: false)
          .uploadUserProfileImage(
        context: context,
        imageFile: _image!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.read<LoginProvider>();
    final userDetailsProvider = context.watch<UserDetailsProvider>();
    _class = context.watch<LoginProvider>().classes;
    _syllabus = context.watch<LoginProvider>().syllabus;
    String? classDropdownValue = loginProvider.getClassNameById(
      userDetailsProvider.userDetails.data!.qualification!,
    );
    String? syllabusDropdownValue = loginProvider.getSyllabusNameById(
     userDetailsProvider.userDetails.data!.syllabus!,
    );
    bool isloading = userDetailsProvider.isUpdating;
    
    if (isloading) {
      return Scaffold(
        body: Center(
          child: Lottie.asset('assets/lottie/lottieloading1.json'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
        title: const Text(
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: _image != null
                              ? Image.file(
                                  _image!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : (_profileImageUrl != null &&
                                      _profileImageUrl!.isNotEmpty)
                                  ? Image.network(
                                      _profileImageUrl!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        // fallback if image loading fails
                                        return Image.asset(
                                          "assets/images/basil.jpg",
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.asset(
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
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: AppColor.greyCardBackground,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: AppColor.greyStroke),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildImagePickerDialog(context),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 15,
                                color: AppColor.greyIconDark,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    GreystokeTextfield(
                      controller: firstnameController,
                      labelText: "First Name",
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? "First name is required"
                              : null,
                    ),
                    const SizedBox(height: 15),
                    GreystokeTextfield(
                      controller: lastnameController,
                      labelText: "Last Name",
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? "Last name is required"
                              : null,
                    ),
                    const SizedBox(height: 15),
                    GreystokeTextfield(
                      controller: emailController,
                      labelText: "Email",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email is required";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(              
                      controller: phoneController,
                      enabled: false, 
                      style: const TextStyle(color: AppColor.greyText),
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: TextStyle(color: AppColor.greyText),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(color: AppColor.greyStroke, width: 1),
                        ),
                        prefix: Text(
                          '$codeController ',
                          style: const TextStyle(
                            color: AppColor.greyText,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.phone_android_outlined,
                          color: AppColor.greyIcon,
                          size: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // DOB field with GestureDetector + GreystokeTextfield
                    GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime(2000),
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
                                "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: GreystokeTextfield(
                          labelText: "Dob",
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
                    const SizedBox(height: 15),

                    // Gender selection
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: ['male', 'female', 'other'].map((gender) {
                            return Row(
                              children: [
                                Radio<String>(
                                  value: gender,
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                ),
                                Text(
                                  gender[0].toUpperCase() + gender.substring(1),
                                  style: TextStyle(
                                    color: _selectedGender == gender
                                        ? AppColor.blackColor
                                        : AppColor.greyText,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: dropdown(
                            "Class",
                            _class
                                .map((classmodel) => classmodel.name ?? "")
                                .toList(),
                            classDropdownValue,
                            (value) => context
                                .read<LoginProvider>()
                                .updateClassDropdown(value!),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: dropdown(
                            "Syllabus",
                            _syllabus
                                .map(
                                    (syllabusmodel) => syllabusmodel.name ?? "")
                                .toList(),
                            syllabusDropdownValue,
                            (value) => context
                                .read<LoginProvider>()
                                .updateSyllabusDropdown(value!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    GreystokeTextfield(
                      controller: schoolController,
                      labelText: "School",
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? "School name is required"
                              : null,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            buttoncolor: AppColor.greyButton,
                            onpressed: () => Navigator.pop(context),
                            text: 'Cancel',
                            textColor: AppColor.greyTextDark,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                            buttoncolor: AppColor.primaryColor,
                            onpressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final updateProvider =
                                    context.read<UserDetailsProvider>();
                                final loginProvider =
                                    context.read<LoginProvider>();

                                final selectedClassId =
                                    loginProvider.getClassIdByName(
                                  loginProvider.classDropdown!,
                                );
                                final selectedSyllabusId =
                                    loginProvider.getSyllabusIdByName(
                                  loginProvider.syllabusDropdown!,
                                );

                                await updateProvider.updateUserProfile(
                                  context: context,
                                  firstName: firstnameController.text.trim(),
                                  lastName: lastnameController.text.trim(),
                                  email: emailController.text.trim(),
                                  userClass: selectedClassId ?? '',
                                  syllabus: selectedSyllabusId ?? '',
                                  school: schoolController.text.trim(),
                                  code: codeController ?? '',
                                  phone: phoneController.text.trim(),
                                  gender: _selectedGender ?? '',
                                  dob: dobController.text.trim(),
                                );

                                if (updateProvider.userDetails.type ==
                                    'success') {
                                  showSnackbar(context, "User Details Updated Successfully");    
                                  Navigator.pop(context);
                                }
                              }
                            },
                            text: 'Update',
                            textColor: AppColor.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePickerDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Choose an option", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FloatingActionButton.extended(
                    backgroundColor: AppColor.greyButton,
                    heroTag: "gallery",
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.photo),
                    label: const Text("Gallery"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FloatingActionButton.extended(
                    backgroundColor: AppColor.greyButton,
                    heroTag: "camera",
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField<String> dropdown(
    String hint,
    List<String> items,
    String? dropdownValue,
    Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      icon: Icon(Icons.keyboard_arrow_down_outlined, color: AppColor.greyText),
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: AppColor.blackColor,
        overflow:  TextOverflow.ellipsis,
      ),
      isExpanded: true,
      dropdownColor: AppColor.greyBackground,
      decoration: InputDecoration(
        labelText: hint, 
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
      ),
      hint: Text(hint, style: TextStyle(color: AppColor.greyText)),
      value: dropdownValue,
      onChanged: (String? newValue) => onChanged(newValue),
      validator: (value) => value == null ? 'Please select $hint' : null,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines:1 ,
          ),
        );
      }).toList(),
    );
  }
}

class GreystokeTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final IconData? iconData;
  final String? Function(String?)? validator;

  const GreystokeTextfield({
    super.key,
    required this.controller,
    this.hintText,
    this.iconData,
    this.validator,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly:
          iconData != null, // Readonly only if icon is provided (like DOB)
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        suffixIcon: iconData != null ? Icon(iconData) : null,
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
      ),
    );
  }
}
