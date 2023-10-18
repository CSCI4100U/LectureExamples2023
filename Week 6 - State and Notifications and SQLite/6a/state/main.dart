import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/friends_model.dart';
import 'views/friend_list_page.dart';

//TODO: Modify this so that it has each page (add friend, friend list, delete friend) in a separate page
//Also, make friend less simple than just a string (e.g. use a friend class)

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FriendsModel(),
      child: MaterialApp(
        title: 'Friend List App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FriendListPage(),
      ),
    );
  }
}