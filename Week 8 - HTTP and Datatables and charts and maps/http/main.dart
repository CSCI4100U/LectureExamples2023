import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Request App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController bodyTextController = TextEditingController();
  TextEditingController userIDTextController = TextEditingController();

  String responseText = "";

  void makeGetRequest() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        responseText = jsonResponse['title'];
      });
    } else {
      setState(() {
        responseText = 'Error: ${response.statusCode}';
      });
    }
  }

  void makePostRequest() async {
    String titleData = titleTextController.text;
    String bodyData = bodyTextController.text;
    String userIdData = userIDTextController.text;

    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': titleData,
        'body': bodyData,
        'userId': userIdData,
      }),
    );

    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        responseText = 'Post created with ID: ${jsonResponse['id']}';
        responseText += '\nTitle: ${jsonResponse['title']}';
        responseText += '\nBody: ${jsonResponse['body']}';
        responseText += '\nUserID: ${jsonResponse['userId']}';
      });
    } else {
      setState(() {
        responseText = 'Error: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Request App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Response:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              responseText,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: titleTextController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: bodyTextController,
              decoration: InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: userIDTextController,
              decoration: InputDecoration(
                labelText: 'User ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: makePostRequest,
              child: Text('POST Data'),
            ),
            ElevatedButton(
              onPressed: makeGetRequest,
              child: Text('GET Data'),
            ),
          ],
        ),
      ),
    );
  }
}
