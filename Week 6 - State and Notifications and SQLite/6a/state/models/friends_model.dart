import 'package:flutter/material.dart';

class FriendsModel extends ChangeNotifier {
  List<String> friends = [];

  void addFriend(String name) {
    friends.add(name);
    notifyListeners();
  }

  void deleteFriend(String name) {
    friends.remove(name);
    notifyListeners();
  }
}