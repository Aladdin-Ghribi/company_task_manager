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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            // SizedBox(height: 17.0),
            // TextField(
            //   controller: null,
            //   decoration: InputDecoration(labelText: "Email",border: OutlineInputBorder()),
            // ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                String password = _passwordController.text;
                if (username.isNotEmpty && password.isNotEmpty){
                  debugPrint("Loggin in with Username: $username");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TaskListScreen()));
                }else{
                    debugPrint("Please enter both username and password");
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}



class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // Hardcoded list of tasks for now
  final List<Map<String, dynamic>> _tasks = [
    {"title": "Finish report", "completed": false},
    {"title": "Call client", "completed": false},
    {"title": "Team meeting", "completed": false},
  ];

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Task List'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    ),
    body: ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_tasks[index]["title"]),
          subtitle: Text("important"),
          textColor: Colors.purple[500],
          trailing: Checkbox(
            value: _tasks[index]["completed"],
            onChanged: (value) {
              setState(() {
                _tasks[index]["completed"] = value!;
                debugPrint("${_tasks[index]["title"]} marked as ${value ? 'done' : 'not done'}");
              });
            },
          ),
        );
      },
    ),
  );
}
}