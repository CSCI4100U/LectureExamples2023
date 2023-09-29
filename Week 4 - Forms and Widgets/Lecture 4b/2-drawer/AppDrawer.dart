import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final Function(String) onTap;

  AppDrawer({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Menu', style: TextStyle(fontSize: 36),),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Form Page'),
            onTap: () {
              onTap('Form Page'); // Pass the page name to the onTap function
            },
          ),
          ListTile(
            title: Text('Display Page'),
            onTap: () {
              onTap('Display Page'); // Pass the page name to the onTap function
            },
          ),
        ],
      ),
    );
  }
}