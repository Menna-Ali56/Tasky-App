import 'package:flutter/material.dart';
import 'package:tasky/feature/home/data/firebase/task_firebase.dart';
import 'package:tasky/feature/home/data/model/task_model.dart';
import 'package:tasky/feature/home/ui/widget/show_dialog_priority.dart';
import 'package:tasky/feature/home/ui/widget/show_modal_bottom_widget.dart';
import 'package:tasky/feature/home/ui/widget/task_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var taskTitle = TextEditingController();
  var taskDescribtion = TextEditingController();
  var selectedDate = DateTime.now();
  var selectedPriority = 1;
  bool isCompleted = false;
  DateTime helperDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appBarWidget(),
              SizedBox(height: 30),
              HeaderDateWidget(
                callback: (date) {
                  setState(() {
                    helperDate = date ?? DateTime.now();
                  });
                },
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<TaskModel>>(
                  future: TaskFirebase.getTasks(helperDate),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                        snapshot.error.toString(),
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<TaskModel> tasks = snapshot.data ?? [];
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) => TaskItemWidget(
                            title: tasks[index].title ?? " No Title",
                            date: tasks[index].date ?? DateTime.now(),
                            isCompleted: tasks[index].isCompleted ?? false,
                            priority: tasks[index].priority ?? 1,
                            onChanged: (value) {
                              setState(() {
                                tasks[index] = TaskModel(
                                  title: tasks[index].title,
                                  describtion: tasks[index].describtion,
                                  date: tasks[index].date,
                                  priority: tasks[index].priority,
                                  isCompleted: value ?? false,
                                );
                              });
                            }),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => ShowModalBottomSheetWidget(
                    taskTitle: taskTitle,
                    taskDescribtion: taskDescribtion,
                    onTapDate: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 30)),
                          initialDate: DateTime.now());
                      if (newDate != null) {
                        selectedDate = newDate;
                      }
                    },
                    onTapFlag: () {
                      showDialog(
                          context: context,
                          builder: (context) => ShowDialogPriorityWidget(
                                callback: (index) {
                                  selectedPriority = index;
                                },
                              ));
                    },
                    onTapSend: () async {
                      // log(taskTitle.text);
                      // log(taskDescribtion.text);
                      // log(selectedPriority.toString());
                      // log(selectedDate.toString());
                      await TaskFirebase.addTask(TaskModel(
                        title: taskTitle.text,
                        describtion: taskDescribtion.text,
                        date: selectedDate,
                        priority: selectedPriority,
                      ));
                    },
                  ));
        },
        shape: CircleBorder(),
        backgroundColor: Color(0xff24252C),
        child: Icon(
          Icons.add,
          size: 40,
          color: Color(0xff5F33E1),
        ),
      ),
    );
  }

  Widget _emptyScreenTask() {
    return Column(
      children: [
        Image.asset('assets/images/empty_home_screeen.png'),
        Text(
          "What do you want to do today?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xff24252C),
          ),
        ),
        Text(
          "Tap + to add your tasks",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff24252C),
          ),
        )
      ],
    );
  }

  Widget _appBarWidget() {
    return Row(
      children: [
        Image.asset('assets/icons/task.png', width: 60, height: 20),
        SizedBox(height: 5),
        Image.asset(
          'assets/icons/y_logo.png',
          height: 20,
          width: 15,
        ),
        const Spacer(),
        Image.asset(
          'assets/icons/logout_icon.png',
          width: 24,
          height: 24,
        ),
        SizedBox(height: 5),
        Text(
          "Logout",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.red),
        ),
      ],
    );
  }
}

class HeaderDateWidget extends StatefulWidget {
  HeaderDateWidget({
    Key? key,
    required this.callback,
  }) : super(key: key);
  final Function(DateTime?) callback;
  @override
  State<HeaderDateWidget> createState() => _HeaderDateWidgetState();
}

class _HeaderDateWidgetState extends State<HeaderDateWidget> {
  DateTime helperDate = DateTime.now();
  final List<DateTime> dates =
      List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff6E6A7C), width: 1.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _getDayName(helperDate),
            style: TextStyle(
              color: Color(0xff6E6A7C),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButton(
            padding: EdgeInsets.zero,
            elevation: 0,
            items: dates
                .map((date) => DropdownMenuItem(
                      value: date,
                      child: Text(_getDayName(date)),
                    ))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                helperDate = value;
              });
              widget.callback(value);
            },
            icon: Icon(Icons.arrow_drop_down_rounded),
          )
        ],
      ),
    );
  }

  String _getDayName(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final target = DateTime(date.year, date.month, date.day);
    if (target == today) {
      return 'Today';
    } else if (target == tomorrow) {
      return "Tomorrow";
    } else {
      return "${date.day}/${date.month}";
    }
  }
}
