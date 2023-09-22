import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Padding, Align, and Expanded Example',
      home: PaddingAlignExpandedExample(),
    );
  }
}

class PaddingAlignExpandedExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Padding, Align, and Expanded Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Example 1: Padding
          Padding(
            padding: EdgeInsets.all(150.0),
            child: Container(
              color: Colors.red,
              width: 100.0,
              height: 50.0,
              child: Center(
                child: Text('Padding'),
              ),
            ),
          ),
          SizedBox(height: 20.0),

          // Example 2: Align
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              color: Colors.green,
              width: 100.0,
              height: 50.0,
              child: Center(
                child: Text('Align'),
              ),
            ),
          ),
          SizedBox(height: 20.0),

          // Example 3: Expanded
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.blue,
                  height: 50.0,
                  child: Center(
                    child: Text('Expanded (2/3)'),
                  ),
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.orange,
                  height: 150.0,
                  child: Center(
                    child: Text('Expanded (1/3)'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}