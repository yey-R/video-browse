import 'package:firebase_auth/firebase_auth.dart';

class CreateUser {
  final String _email;
  final String _password;
  CreateUser(this._email, this._password);

  void createUser() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      // ignore: empty_catches
    } on FirebaseAuthException {}
  }
}
