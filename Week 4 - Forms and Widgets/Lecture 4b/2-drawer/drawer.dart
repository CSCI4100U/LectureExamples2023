import 'package:flutter/material.dart';
import 'FormPage.dart';
import 'AppDrawer.dart';
import 'display_page.dart';

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
      drawer: AppDrawer(onTap: (page) {
        Navigator.pop(context); // Close the drawer
        if (page == 'Form Page') {
          _openFormPage();
        } else if (page == 'Display Page') {
          _openDisplayPage(_displayedUsername!,_displayedEmail!);
        }
      }),
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

  void _openFormPage() async {
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
  }

  void _openDisplayPage(String username, String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPage(username: username, email: email),
      ),
    );
  }

}

