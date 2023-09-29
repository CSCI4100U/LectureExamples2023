import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Switcher App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ColorSwitcher(),
    );
  }
}

class ColorSwitcher extends StatefulWidget {
  @override
  _ColorSwitcherState createState() => _ColorSwitcherState();
}

class _ColorSwitcherState extends State<ColorSwitcher> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    if (_currentIndex == 0 && index == 1) {
      _showGoDialog();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  Future<void> _showGoDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Go'),
          content: Text('Are you sure you want to go to the Green screen?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Go'),
              onPressed: () {
                setState(() {
                  _currentIndex = 1; // Switch to the Green screen
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      ColorScreen(color: Colors.red),
      ColorScreen(color: Colors.green),
      ColorScreen(color: Colors.blue),
      ColorScreen(color: Colors.yellow),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Color Switcher App'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Red',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Green',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Blue',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Yellow',
          ),
        ],
      ),
    );
  }
}

class ColorScreen extends StatelessWidget {
  final Color color;

  ColorScreen({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}