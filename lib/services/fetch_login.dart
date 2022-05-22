import 'package:firebase_auth/firebase_auth.dart';

class FetchLogin {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  String email;
  String password;

  FetchLogin(this.email, this.password);

  Future<bool> checkAuth() async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      return false;
    }
    return true;
  }
}
