import 'package:company_task_manager/screans/task_list_page.dart';
import 'package:flutter/material.dart';

class LoginScrean extends StatelessWidget {
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