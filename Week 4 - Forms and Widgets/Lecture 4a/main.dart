//Homework:
//1) make it so they confirm their password (i.e. they should match)
//2) Fix this so the password requirements show up when i click
//on the field


import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  String _password = '';
  bool _showPasswordRequirements = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showPasswordRequirements = true;
                  });
                },
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: _showPasswordRequirements
                        ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPasswordRequirements = true;
                        });
                      },
                      child: Icon(Icons.close),
                    )
                        : null,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    } else if (!RegExp(r'\d').hasMatch(value)) {
                      return 'Password must contain at least one number';
                    }
                    return null;
                  },
                ),
              ),
              if (_showPasswordRequirements)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Password Requirements:'),
                      Text('• At least 8 characters long'),
                      Text('• Must contain at least one number'),
                    ],
                  ),
                ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _password = _passwordController.text;
                    });
                  }
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 20.0),
              Text('Entered Password: $_password'),
            ],
          ),
        ),
      ),
    );
  }
}
