import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_dialog.dart';
import 'package:tasky/core/utils/validator.dart';
import 'package:tasky/core/widgets/material_button_widget.dart';
import 'package:tasky/core/widgets/text_form_field_helper.dart';
import 'package:tasky/feature/auth/data/firebase/auth_firebase.dart';
import 'package:tasky/feature/auth/ui/view/login_screen.dart';
import 'package:tasky/feature/auth/ui/widget/state_member_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static const String routeName = 'RegisterScreen';

  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var userName = TextEditingController();

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
                  'Register',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff404147),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff404147),
                  ),
                ),
                SizedBox(height: 5),
                TextFormFieldHelper(
                  hint: "Enter Your User Name",
                  borderRadius: BorderRadius.circular(10),
                  validator: Validator.validateName,
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                Text(
                  "Confirm Password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff404147),
                  ),
                ),
                SizedBox(height: 5),
                TextFormFieldHelper(
                  hint: "Enter Your Confirm Password",
                  borderRadius: BorderRadius.circular(10),
                  validator: (text) =>
                      Validator.validateConfirmPassword(text, password.text),
                  isPassword: true,
                ),
                SizedBox(height: 50),
                MaterialButtonWidget(
                  title: "Register",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      AppDialog.showLoadingDialog(context);
                      await register(email.text, password.text).then((_) async {
                        await AuthFirebase.addUser(
                            email: email.text,
                            password: password.text,
                            userName: userName.text);
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      }).catchError((error) {
                        Navigator.of(context).pop();
                        AppDialog.showErrorDialog(context, error.toString());
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: kIsWeb
          ? StateMemberWidget(
              title: "Already have an account?",
              subTitle: "Login",
              onTap: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
            )
          : MediaQuery.of(context).viewInsets.bottom != 0
              ? StateMemberWidget(
                  title: "Already have an account?",
                  subTitle: "Login",
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              : SizedBox.shrink(),
    );
  }

  Future<void> register(String email, String password) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
