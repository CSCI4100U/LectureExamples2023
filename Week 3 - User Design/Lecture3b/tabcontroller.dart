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
      title: 'Tab Controller Example',
      home: TabControllerExample(),
    );
  }
}

class TabControllerExample extends StatefulWidget {
  @override
  _TabControllerExampleState createState() => _TabControllerExampleState();
}

class _TabControllerExampleState extends State<TabControllerExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with the desired number of tabs (e.g., 3)
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the TabController when it's no longer needed
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab Controller Example'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListViewExample(), //index 0
          GridViewExample(), //index 1
          ContainerLayout(), //index 2
        ],
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final String title;

  TabContent({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
