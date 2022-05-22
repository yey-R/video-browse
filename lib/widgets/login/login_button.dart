import 'package:flutter/material.dart';
import 'package:video_browse/utilities/constants.dart';

class LoginButton extends StatelessWidget {
  final String buttonText;
  const LoginButton({
    Key? key,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      margin: const EdgeInsets.only(
        right: 12.0,
        left: 12.0,
        top: 6.0,
        bottom: 10.0,
      ),
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: kColorActive,
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: const TextStyle(
            color: kColorPrimary,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
