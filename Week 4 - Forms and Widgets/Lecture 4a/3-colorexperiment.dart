import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Update Example',
      home: TextUpdateApp(),
    );
  }
}

class TextUpdateApp extends StatefulWidget {
  @override
  _TextUpdateAppState createState() => _TextUpdateAppState();
}

class _TextUpdateAppState extends State<TextUpdateApp> {
  String labelText = ''; // State variable to store text input
  Color _backgroundColor = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Update Example'),
      ),
      backgroundColor: _backgroundColor, // Set the background color to yellow
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 2.0, // Border width
                ),
                color: calculateOppositeColor(_backgroundColor), // Use the background color of the Scaffold
              ),
              child: Center(
                child: Text(
                  labelText, // Display the text here
                  style: TextStyle(fontSize: 20.0, color: Colors.black), // Text color
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Update the text when the button is pressed
                setState(() {
                  labelText = 'Text from Button'; // Replace with your desired text
                });
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

Color calculateOppositeColor(Color color) {
  return Color.fromARGB(
    255,
    255 - color.red,
    255 - color.green,
    255 - color.blue,
  );
}
