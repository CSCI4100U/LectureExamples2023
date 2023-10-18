import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/friends_model.dart';

class AddFriendPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final friendsModel = Provider.of<FriendsModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Friend'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                friendsModel.addFriend(name);
                Navigator.pop(context);
              },
              child: Text('Add Friend'),
            ),
          ],
        ),
      ),
    );
  }
}