import 'package:flutter/material.dart';

class FormPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final username = _usernameController.text;
                final email = _emailController.text;

                if (username.isNotEmpty && email.isNotEmpty) {
                  Navigator.pop(context, {
                    'username': username,
                    'email': email,
                  });
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
