import 'package:flutter/material.dart';
import 'user_model.dart';
import 'database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late DatabaseHelper _databaseHelper;
  User? _recentUser;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _loadRecentUser();
  }

  Future<void> _loadRecentUser() async {
    final user = await _databaseHelper.getRecentUser();
    setState(() {
      _recentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Flutter App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final username = _usernameController.text;
                  final password = _passwordController.text;
                  final user = User(username: username, password: password);
                  await _databaseHelper.insertUser(user);
                  _loadRecentUser();
                }
              },
              child: Text('Save'),
            ),
            SizedBox(height: 16.0),
            _recentUser != null
                ? Text(
              'Most Recent User: ${_recentUser!.username} - ${_recentUser!.password}',
              style: TextStyle(fontSize: 16),
            )
                : Text('No recent user data available'),
          ],
        ),
      ),
    );
  }
}