import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wrap Variations Example',
      home: WrapVariationsExample(),
    );
  }
}

class WrapVariationsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wrap Variations Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Example 1: Basic Wrap
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Example 1: Basic Wrap',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                15,
                    (index) => Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.blue,
                  child: Center(
                    child: Text('Item $index'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            // Example 2: Alignment
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Example 2: Alignment',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.spaceBetween,
              children: List.generate(
                15,
                    (index) => Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.green,
                  child: Center(
                    child: Text('Item $index'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            // Example 3: Direction
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Example 3: Direction',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              direction: Axis.vertical,
              children: List.generate(
                15,
                    (index) => Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.orange,
                  child: Center(
                    child: Text('Item $index'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            // Example 4: Alignment & Direction
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Example 4: Alignment & Direction',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.spaceBetween,
              direction: Axis.vertical,
              children: List.generate(
                15,
                    (index) => Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.purple,
                  child: Center(
                    child: Text('Item $index'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
