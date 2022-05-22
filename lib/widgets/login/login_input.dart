import 'package:flutter/material.dart';
import 'package:video_browse/screens/loading_screen.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/login/login_button.dart';

class LoginInput extends StatelessWidget {
  const LoginInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/2.gif",
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
            onPressed: () {},
            child: const Text(
              "Don't have any account? Sign up",
              style: TextStyle(
                color: kColorOwnerText,
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoadingScreen(
                    email: email,
                    password: password,
                  ),
                ),
              );
            },
            child: const LoginButton(buttonText: "Log in"),
          ),
        ],
      ),
    );
  }
}
