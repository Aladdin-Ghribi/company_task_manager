import 'package:company_task_manager/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  String appName = "Company Task Manager";
  debugPrint("Starting $appName...");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Company Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 10, 93, 227)),
      ),
      home: LoginScreen(),
    );
  }
}
