import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Logo Grid',
      home: LogoGrid(),
    );
  }
}

class LogoGrid extends StatefulWidget {
  @override
  _LogoGridState createState() => _LogoGridState();
}

class _LogoGridState extends State<LogoGrid> {
  Color _backgroundColor = Colors.white;

  void _changeBackgroundColor() {
    setState(() {
      // Generate a random color
      _backgroundColor = Color(0xFF000000 + (Random().nextDouble() * 0xFFFFFF).toInt());
    });
  }

  Widget _buildLogo() {
    return FlutterLogo(size: 60.0);
  }

  List<Widget> _buildRow() {
    return List.generate(5, (index) => _buildLogo());
  }

  List<Widget> _buildColumns() {
    return List.generate(3, (index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildRow(),
      );
    });
  }

  //HW: Move the stack circle behind the logos!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Logo Grid'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    child: Text("HIIIIIIII"),
                    backgroundColor: Colors.amber,
                    radius: 150,
                  ),
                ),
                Column(
                  children: _buildColumns(),
                ),
              ],
            ),
            SizedBox(height: 16.0), // Added spacing
            Text(
              'Hi CSCI 4100!',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeBackgroundColor,
        tooltip: 'Change Color',
        child: Icon(Icons.color_lens),
      ),
      backgroundColor: _backgroundColor,
    );
  }
}
