// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tasky/core/widgets/text_form_field_helper.dart';

class ShowModalBottomSheetWidget extends StatelessWidget {
  ShowModalBottomSheetWidget({
    Key? key,
    this.onTapDate,
    this.onTapFlag,
    this.onTapSend,
    required this.taskTitle,
    required this.taskDescribtion,
  }) : super(key: key);
  final void Function()? onTapDate;
  final void Function()? onTapFlag;
  final void Function()? onTapSend;
  final TextEditingController taskTitle;
  final TextEditingController taskDescribtion;
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          top: 20,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15,
        children: [
          Text(
            "Add Task",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff24252C)),
          ),
          TextFormFieldHelper(
            hint: "Do math homework",
            borderRadius: BorderRadius.circular(8),
            controller: taskTitle,
          ),
          TextFormFieldHelper(
            hint: "Description",
            borderRadius: BorderRadius.circular(8),
            controller: taskDescribtion,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: onTapDate,
                child: Image.asset('assets/icons/timer.png'),
              ),
              SizedBox(width: 14),
              GestureDetector(
                onTap: onTapFlag,
                child: Image.asset('assets/icons/flag_icon.png'),
              ),
              Spacer(),
              GestureDetector(
                onTap: onTapSend,
                child: Image.asset('assets/icons/send_icon.png'),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
