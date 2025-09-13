import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/material_button_widget.dart';
import 'package:tasky/feature/home/ui/widget/priority_widget.dart';

class ShowDialogPriorityWidget extends StatefulWidget {
  const ShowDialogPriorityWidget({super.key, required this.callback});
  final Function(int) callback;
  @override
  State<ShowDialogPriorityWidget> createState() =>
      _ShowDialogPriorityWidgetState();
}

class _ShowDialogPriorityWidgetState extends State<ShowDialogPriorityWidget> {
  List<int> priorityList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int selectPriority = 1;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Column(
          children: [
            Text(
              "Add Priority",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff24252C)),
            ),
            Divider(color: Color(0xff979797)),
          ],
        ),
        content: Wrap(
          children: priorityList
              .map((index) => PriorityItemWidget(
                    index: index,
                    isSelected: index == selectPriority ? true : false,
                    onTap: () {
                      selectPriority = index;
                      widget.callback(selectPriority);
                      setState(() {});
                    },
                  ))
              .toList(),
        ),
        actions: [
          MaterialButtonWidget(
              title: "Done", onPressed: () => Navigator.pop(context))
        ]);
  }
}
