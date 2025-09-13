import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  TaskItemWidget({
    Key? key,
    required this.title,
    required this.priority,
    required this.date,
    required this.isCompleted,
    required this.onChanged,
  }) : super(key: key);
  final String title;
  final int priority;
  final DateTime date;
   final bool isCompleted;
  final  void Function(bool?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff6E6A7C), width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(children: [
          Radio<bool>(
              value: true,
              groupValue: isCompleted,
              onChanged: (value) {
                onChanged(value);
              }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff404147)),
              ),
              Text(
                date.toString(),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff404147)),
              ),
            ],
          ),
          Spacer(),
          Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff6E6A7C), width: 1.5),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                spacing: 10,
                children: [
                  Image.asset('assets/icons/flag_icon.png'),
                  Text(
                    priority.toString(),
                    style: TextStyle(
                        color: Color(0xff404147),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ))
        ]));
  }
}
