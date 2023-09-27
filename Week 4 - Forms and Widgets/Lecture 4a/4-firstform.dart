import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Form Example',
      home: SimpleFormApp(),
    );
  }
}

class SimpleFormApp extends StatefulWidget {
  @override
  _SimpleFormAppState createState() => _SimpleFormAppState();
}

class _SimpleFormAppState extends State<SimpleFormApp> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool formSubmitted = false; // Track whether the form is submitted

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Form Example'),
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
                // Hide the username field if the form is not submitted
                enabled: !formSubmitted,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                // Show the password field always
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Save the form and set formSubmitted to true
                  setState(() {
                    formSubmitted = true;
                  });
                  _formKey.currentState!.save();
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 20.0),
              if (formSubmitted) // Show values only if form is submitted
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