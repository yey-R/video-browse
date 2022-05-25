import 'package:flutter/material.dart';
import 'package:video_browse/services/fetch_user.dart';

class User {
  final String _uid;
  dynamic user;

  User(
    this._uid,
  ) {
    setUser();
  }

  void setUser() async {
    user = await FetchUser().getUser(_uid);
  }

  String getUsername() {
    return "@" + user['username'];
  }

  Widget getProfilePicture({flag = false}) {
    return user['profilePic'].isEmpty
        ? const Icon(Icons.person)
        : CircleAvatar(
            radius: flag ? 100.0 : 20.0,
            backgroundImage: NetworkImage(
              user['profilePic'],
            ));
  }
}
