import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GridView Example',
      home: GridViewExample(),
    );
  }
}

class GridViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView Example'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of columns
              crossAxisSpacing: 16.0, // Spacing between columns
              mainAxisSpacing: 16.0, // Spacing between rows
            ),
            itemCount: 50, // Number of items in the grid
            itemBuilder: (BuildContext context, int index) {
              final color = Colors.primaries[index % Colors.primaries.length];

              return Container(
                color: color,
                child: Center(
                  child: Text('Item $index', style: TextStyle(color: Colors.white)),
                ),
              );
            },
          ),
      ),
    );
  }
}