import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CreateUser {
  static final validChars = RegExp(r'^[a-zA-Z0-9]+$');
  static final emailValidChars = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final ImagePicker _picker = ImagePicker();
  final Reference _storageRef = FirebaseStorage.instance.ref();
  final FirebaseDatabase _dbInstance = FirebaseDatabase.instance;
  final Function fun;
  dynamic _dbRef;
  dynamic _profilePic;
  dynamic _pickedFile;
  dynamic _credential;
  dynamic _filePath;
  dynamic username;
  dynamic email;
  dynamic password;

  CreateUser({
    required this.fun,
  });

  bool checkCredentials(email, username, password) {
    this.email = email;
    this.username = username;
    this.password = password;

    if (email == null || !emailValidChars.hasMatch(email)) {
      fun("email");
      return false;
    } else if (password == null ||
        password.length < 5 ||
        !validChars.hasMatch(password)) {
      fun("password");
      return false;
    } else if (username == null ||
        !validChars.hasMatch(username) ||
        username.length < 3) {
      fun("username");
      return false;
    }
    return true;
  }

  Future<void> createUser() async {
    _dbRef = await _dbInstance.ref("users").get();

    // Check if the same username exists
    if (_dbRef.exists) {
      for (String key in _dbRef.value.keys) {
        if (_dbRef.value[key]['username'] == username) {
          throw Exception("username-exists");
        }
      }
    }

    // Register the email and password
    _credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Sign in with credentials
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    //Upload profile picture and write meta-data
    // Metadata = {"username": username, "profilePic": picLink}
    if (_filePath != null) await uploadProfilePicture();
    await writeMetadata(username);
    // ignore: empty_catches
  }

  Future<String> pickProfilePicture() async {
    try {
      _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      _filePath = _pickedFile.path;
    } catch (e) {
      return "";
    }
    return _filePath;
  }

  Future<void> writeMetadata(String username) async {
    _dbRef = _dbInstance.ref("users/${_credential.user.uid}");
    await _dbRef.set(
      {
        "username": username,
        "profilePic": _profilePic ?? "",
      },
    );
  }

  Future<void> uploadProfilePicture() async {
    final ref = _storageRef.child("users/${_credential.user.uid}");
    File file = File(_filePath);
    try {
      await ref.putFile(file);
      // ignore: empty_catches
    } on FirebaseException {}
    _profilePic = await ref.getDownloadURL();
  }
}
