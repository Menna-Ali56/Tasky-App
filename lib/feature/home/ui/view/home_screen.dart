import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = "HomeScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Column(
            children: [
              _appBarWidget(),
              Spacer(flex: 1),
              _emptyScreenTask(),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: CircleBorder(),
          backgroundColor: Color(0xff24252C),
          child: Icon(
            Icons.add,
            size: 40,
            color: Color(0xff5F33E1),),
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
