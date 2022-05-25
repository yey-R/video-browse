import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:video_browse/models/user.dart' as CustomUser;

class FetchUser {
  static final FetchUser _fetchUser = FetchUser._internal();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  dynamic currentUser;
  dynamic user;
  dynamic uid;

  factory FetchUser() {
    return _fetchUser;
  }

  FetchUser._internal();

  void setUser() async {
    user = auth.currentUser;
    uid = user.uid;
    final snapshot = await _dbRef.child('users').child("$uid").get();
    if (snapshot.exists) {
      currentUser = CustomUser.User(uid);
    }
  }

  String getCurrentUserUID() {
    return uid;
  }

  Future<Object?> getUser(String uid) async {
    final snapshot = await _dbRef.child('users').child('$uid').get();
    if (snapshot.exists) {
      return snapshot.value;
    }
  }
}
