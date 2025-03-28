import 'package:company_task_manager/screans/add_task_page.dart';
import 'package:company_task_manager/screans/edit_task_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late List<Map<String, dynamic>> _tasks;

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks when screen starts
  }

  Future<void> _loadTasks() async {
  debugPrint("Loading tasks...");
  final prefs = await SharedPreferences.getInstance();
  final taskStrings = prefs.getStringList('tasks') ?? [];
  setState(() {
    _tasks = taskStrings.map((task) {
      final parts = task.split('|');
      return {"title": parts[0], "completed": parts[1] == 'true'};
    }).toList();
    if (_tasks.isEmpty) {
      _tasks = [
        {"title": "Finish report", "completed": false},
        {"title": "Call client", "completed": false},
        {"title": "Team meeting", "completed": false},
      ];
    }
    debugPrint("Tasks loaded: $_tasks");
  });
}

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskStrings = _tasks.map((task) {
      return "${task["title"]}|${task["completed"]}";
    }).toList();
    await prefs.setStringList('tasks', taskStrings);
  }

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
            _saveTasks(); // Save after marking all
          },
          tooltip: 'Mark All Complete',
        ),
      ],
    ),
    // ignore: unnecessary_null_comparison
    body: _tasks == null
        ? Center(child: CircularProgressIndicator()) // Loading state
        : ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_tasks[index]["title"]),
                subtitle: Text("important"),
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
                        _saveTasks(); // Save after toggling
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
                        _saveTasks(); // Save after deleting
                      },
                    ),
                  ],
                ),
                onTap: () async {
                  String? updatedTitle = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskScreen(
                        initialTitle: _tasks[index]["title"],
                      ),
                    ),
                  );
                  if (updatedTitle != null) {
                    setState(() {
                      _tasks[index]["title"] = updatedTitle;
                      debugPrint("Updated task to: $updatedTitle");
                    });
                    _saveTasks(); // Save after editing
                  }
                },
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
          _saveTasks(); // Save after adding
        }
      },
      child: Icon(Icons.add),
      tooltip: 'Add Task',
    ),
  );
}
}