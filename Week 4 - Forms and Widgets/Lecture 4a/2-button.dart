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
  String currentText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Update Example'),
      ),
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
              ),
              child: Center(
                child: Text(
                  labelText, // Display the text here
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),

            TextFormField(
              style: TextStyle(fontSize: 24),
              onChanged: (text) {
                  currentText = text; // Update the state variable
              },
              decoration: InputDecoration(
                  labelText: 'Enter Text',
                  labelStyle: TextStyle(fontSize: 24)
              ),
            ),

            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Update the text when the button is pressed
                setState(() {
                  labelText = currentText; // Replace with your desired text
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