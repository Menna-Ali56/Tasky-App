import 'package:flutter/material.dart';

class MaterialButtonWidget extends StatelessWidget {
  MaterialButtonWidget({super.key, this.onPressed, required this.title});
  void Function()? onPressed;
  String title;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 1000,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Color(0xff5F33E1),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xffFFFFFF),
        ),
      ),
    );
  }
}
