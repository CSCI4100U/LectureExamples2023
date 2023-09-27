import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Check Example',
      home: PasswordCheckApp(),
    );
  }
}

class PasswordCheckApp extends StatefulWidget {
  @override
  _PasswordCheckAppState createState() => _PasswordCheckAppState();
}

class _PasswordCheckAppState extends State<PasswordCheckApp> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool showCredentials = false; // Track whether to display credentials

  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Check Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                validator: validateUserName,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                validator: validatePassword, // Use the validator
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      showCredentials = true;
                    });
                  }
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 20.0),
              if (showCredentials)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Username: $username'),
                      Text('Password: $password'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
