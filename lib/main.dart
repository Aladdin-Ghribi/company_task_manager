import 'package:company_task_manager/screans/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show debugPrint;

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScrean(),
    );
  }
}