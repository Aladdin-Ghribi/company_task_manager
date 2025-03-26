import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Task Title',                fillColor: Colors.blue,

                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String newTask = _taskController.text;
                if (newTask.isNotEmpty) {
                  Navigator.pop(context, newTask); // Send task back
                } else {
                  debugPrint("Task title can’t be empty!");
                }
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}