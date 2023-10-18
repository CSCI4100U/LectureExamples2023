import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/friends_model.dart';
import 'add_friend_page.dart';

class FriendListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final friendsModel = Provider.of<FriendsModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend List'),
      ),
      body: ListView.builder(
        itemCount: friendsModel.friends.length,
        itemBuilder: (context, index) {
          final friend = friendsModel.friends[index];
          return ListTile(
            title: Text(friend),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                friendsModel.deleteFriend(friend);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFriendPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}