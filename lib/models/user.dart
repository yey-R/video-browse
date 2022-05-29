import 'package:flutter/material.dart';
import 'package:video_browse/services/fetch_user.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';

class User {
  final String _uid;
  dynamic user;

  User(
    this._uid,
  );

  Future<User> setUser() async {
    user = await FetchUser().getUser(_uid);
    return this;
  }

  String getUsername() {
    return "@" + user['username'];
  }

  String getUID() {
    return _uid;
  }

  Widget getProfilePicture({isBig = false}) {
    return CircleAvatar(
      child: user['profilePic'].isEmpty
          ? const Icon(
              Icons.person,
              color: Colors.white,
            )
          : null,
      radius: isBig
          ? 11.0 * AppScale.heightMultiplier
          : 2.7 * AppScale.heightMultiplier,
      backgroundColor: kColorActive,
      backgroundImage: user['profilePic'].isEmpty
          ? null
          : NetworkImage(
              user['profilePic'],
            ),
    );
  }
}
