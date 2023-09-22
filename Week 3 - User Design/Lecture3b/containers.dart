import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Layout',
      home: ContainerLayout(),
    );
  }
}

class ContainerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container Layout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.red,
                ),
                Container(
                  width: 150.0,
                  height: 150.0,
                  color: Colors.green,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.blue,
                ),
                SizedBox(width: 20.0),
                Container(
                  width: 120.0,
                  height: 120.0,
                  color: Colors.orange,
                ),
                SizedBox(width: 20.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  color: Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              width: 200.0,
              height: 100.0,
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
