import 'package:flutter/material.dart';
import 'package:video_browse/screens/sign_up_screen.dart';
import 'package:video_browse/utilities/constants.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUpScreen(),
          ),
        );
      },
      child: const Text(
        "Don't have any account? Sign up!",
        style: TextStyle(
          color: kColorOwnerText,
        ),
      ),
    );
  }
}
