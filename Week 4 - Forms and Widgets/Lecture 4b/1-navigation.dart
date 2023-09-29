import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _displayedUsername;
  String? _displayedEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Form App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_displayedUsername != null && _displayedEmail != null)
              Text('Username: $_displayedUsername\nEmail: $_displayedEmail'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormPage(),
          ),
        );

        if (result != null && result is Map) {
          setState(() {
            _displayedUsername = result['username'];
            _displayedEmail = result['email'];
          });
        }
      }),
    );
  }
}

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
