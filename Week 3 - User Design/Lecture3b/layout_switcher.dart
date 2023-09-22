import 'package:flutter/material.dart';
import 'listview.dart';
import 'gridview.dart';
import 'containers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout Switcher App',
      home: LayoutSwitcherApp(),
    );
  }
}

class LayoutSwitcherApp extends StatefulWidget {
  @override
  _LayoutSwitcherAppState createState() => _LayoutSwitcherAppState();
}

class _LayoutSwitcherAppState extends State<LayoutSwitcherApp> {
  int _currentIndex = 0; // Index for the current layout

  @override
  Widget build(BuildContext context) {
    final List<Widget> layouts = [
      ListViewExample(), //index 0
      GridViewExample(), //index 1
      ContainerLayout(), //index 2
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Layout Switcher App'),
        actions: [
          IconButton(
            icon: Icon(Icons.view_list),
            onPressed: () {
              _switchLayout(0); // Switch to ListView
            },
          ),
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: () {
              _switchLayout(1); // Switch to GridView
            },
          ),
          IconButton(
            icon: Icon(Icons.aspect_ratio),
            onPressed: () {
              _switchLayout(2); // Switch to ContainerLayout
            },
          ),
        ],
      ),
      body: layouts[_currentIndex], // Display the selected layout
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'ListView',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            label: 'GridView',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.aspect_ratio),
            label: 'ContainerLayout',
          ),
        ],
        onTap: (index) {
          _switchLayout(index); // Switch to the selected layout
        },
      ),
    );
  }

  // Function to switch between layouts
  void _switchLayout(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
