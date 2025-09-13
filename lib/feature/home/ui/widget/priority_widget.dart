import 'package:flutter/material.dart';

class PriorityItemWidget extends StatelessWidget {
  const PriorityItemWidget(
      {Key? key, required this.index, required this.isSelected, this.onTap})
      : super(key: key);
  final int index;
  final isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.only(right: 10, bottom: 10),
        decoration: BoxDecoration(
          border: isSelected
              ? null
              : Border.all(color: Color(0xff6E6A7C), width: 1.5),
          borderRadius: BorderRadius.circular(4),
          color: isSelected ? Color(0xff5F33E1) : Colors.transparent,
        ),
        child: Column(
          children: [
            Image.asset('assets/icons/flag_icon.png',
                color: isSelected ? Color(0xffFFFFFF) : null),
            Text(
              index.toString(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: isSelected ? Color(0xffFFFFFF) : Color(0xff24252C)),
            )
          ],
        ),
      ),
    );
  }
}
