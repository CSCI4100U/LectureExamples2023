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
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 5.0, // Border width
                ),
              ),
              //color: Colors.green,
              alignment: Alignment.center,
              child: Text(
                labelText, // Display the text here
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                style: TextStyle(fontSize: 24),
                onChanged: (text) {
                  setState(() {
                    labelText = text; // Update the state variable
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter Text',
                  labelStyle: TextStyle(fontSize: 24)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}