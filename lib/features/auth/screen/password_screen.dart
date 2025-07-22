import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/auth/screen/forgot_password.dart';
import 'package:etutor/features/auth/widgets/white_button.dart';
import 'package:etutor/features/auth/widgets/whitestroke_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordScreen extends StatelessWidget {
  final String phone;
  final String code;
  const PasswordScreen({super.key,required this.phone,required this.code});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final isLoading = context.watch<LoginProvider>().isLoding;
    final _formKey = GlobalKey<FormState>();


    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body:isLoading ? 
        Center(
          child: CircularProgressIndicator(),
        )
      : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/arrow_topLeft.png"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Image.asset("assets/images/dreamthemlogo.png"),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Enter your password to continue learning",
                    style: TextStyle(
                      color: AppColor.whiteColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        WhiteStrokeTextField(
                          hind: "Enter your Password",
                          isPassword: true,
                          controller: passwordController,
                          validator: (value) {
                              if (value == null || value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        whiteButton(
                          text: "Login",
                          onpressed: ()async{
                            final provider = context.read<LoginProvider>();
                             if (_formKey.currentState!.validate()){
                             await provider.login(context, phone, code, passwordController.text);
                            if (provider.isLogin.isNotEmpty )
                            {
                           Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => BottomNavBarScreen()));
                            } 
                            }              
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                             Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                          },
                          child: Text("Forgot Password?",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColor.whiteColor,
                              )))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("assets/images/arrow_bottomright.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
