import 'package:flutter/material.dart';

class EditTaskScreen extends StatelessWidget {
  final String initialTitle;
  final TextEditingController _taskController;

  EditTaskScreen({required this.initialTitle})
      : _taskController = TextEditingController(text: initialTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.blueAccent)
              ),
              style: TextStyle(color: Colors.blueAccent),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String updatedTask = _taskController.text;
                if (updatedTask.isNotEmpty) {
                  Navigator.pop(context, updatedTask);
                } else {
                  debugPrint("Task title can’t be empty!");
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blueAccent
              ),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}