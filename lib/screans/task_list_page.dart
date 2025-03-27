import 'package:company_task_manager/screans/add_task_page.dart';
import 'package:flutter/material.dart';

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
      actions: [
        IconButton(
          icon: Icon(Icons.check_circle),
          onPressed: () {
            setState(() {
              bool allCompleted = _tasks.every((task) => task["completed"]);
              for (var task in _tasks) {
                task["completed"] = !allCompleted;
              }
              debugPrint("All tasks marked as ${!allCompleted ? 'done' : 'not done'}");
            });
          },
          tooltip: 'Mark All Complete',
        ),
      ],
    ),
    body: ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_tasks[index]["title"]),
          textColor: Colors.purple[500],
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: _tasks[index]["completed"],
                onChanged: (value) {
                  setState(() {
                    _tasks[index]["completed"] = value!;
                    debugPrint("${_tasks[index]["title"]} marked as ${value ? 'done' : 'not done'}");
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    String deletedTask = _tasks[index]["title"];
                    _tasks.removeAt(index);
                    debugPrint("Deleted task: $deletedTask");
                  });
                },
              ),
            ],
          ),
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        String? newTask = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTaskScreen()),
        );
        if (newTask != null) {
          setState(() {
            _tasks.add({"title": newTask, "completed": false});
            debugPrint("Added task: $newTask");
          });
        }
      },
      child: Icon(Icons.add),
      tooltip: 'Add Task',
    ),
  );
}
}