import 'package:flutter/material.dart';
import 'package:video_browse/screens/loading_screen.dart';
import 'package:video_browse/screens/sign_up_screen.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/action_button.dart';

// ignore: must_be_immutable
class LoginInput extends StatelessWidget {
  LoginInput({Key? key}) : super(key: key);

  String email = "";
  String password = "";
  dynamic context;

  void loadingScreen() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            LoadingScreen(email: email, password: password),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/app.gif",
            width: 100.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 250.0,
            child: TextField(
              onChanged: ((value) => email = value),
              cursorColor: Colors.black,
              style: const TextStyle(color: kColorPrimary),
              decoration: InputDecoration(
                hintText: "E Mail",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: 250.0,
            child: TextField(
              onChanged: (value) => (password = value),
              obscureText: true,
              cursorColor: Colors.black,
              style: const TextStyle(color: kColorPrimary),
              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
              );
            },
            child: const Text(
              "Don't have any account? Sign up",
              style: TextStyle(
                color: kColorOwnerText,
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          ActionButton(
            buttonText: "Log in",
            routerPage: null,
            replace: true,
            width: 150,
            fun: loadingScreen,
          ),
        ],
      ),
    );
  }
}
