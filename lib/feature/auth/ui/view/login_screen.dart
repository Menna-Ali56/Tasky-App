import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/validator.dart';
import 'package:tasky/core/widgets/material_button_widget.dart';
import 'package:tasky/core/widgets/text_form_field_helper.dart';
import 'package:tasky/feature/auth/ui/view/register_screen.dart';
import 'package:tasky/feature/auth/ui/widget/state_member_widget.dart';
import 'package:flutter/foundation.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const String routeName = 'LoginScreen';
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff404147),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff404147),
                  ),
                ),
                SizedBox(height: 5),
                TextFormFieldHelper(
                  hint: "Enter Your Email",
                  controller: email,
                  borderRadius: BorderRadius.circular(10),
                  validator: Validator.validateEmail,
                ),
                SizedBox(height: 20),
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff404147),
                  ),
                ),
                SizedBox(height: 5),
                TextFormFieldHelper(
                  hint: "Enter Your Password",
                  borderRadius: BorderRadius.circular(10),
                  controller: password,
                  validator: Validator.validatePassword,
                  isPassword: true,
                ),
                SizedBox(height: 50),
                MaterialButtonWidget(
                  title: "Login",
                  onPressed: () {
                    log("Home Screen");

                    if (formKey.currentState!.validate()) {
                      // Perform login action
                    }
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: kIsWeb
          ? StateMemberWidget(
              title: "Don't have an account? ",
              subTitle: "Register",
              onTap: () {
                Navigator.of(context).pushNamed(RegisterScreen.routeName);
              },
            )
          : MediaQuery.of(context).viewInsets.bottom != 0
              ? StateMemberWidget(
                  title: "Don't have an account? ",
                  subTitle: "Register",
                  onTap: () {
                    Navigator.of(context).pushNamed(RegisterScreen.routeName);
                  },
                )
              : null,
    );
  }
}
