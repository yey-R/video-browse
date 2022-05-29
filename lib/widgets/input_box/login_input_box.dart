import 'package:flutter/material.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';

class LoginInputBox extends StatelessWidget {
  final Function fun;
  final String hint;
  final bool obscure;
  const LoginInputBox({
    Key? key,
    required this.fun,
    required this.hint,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 1.1 * AppScale.heightMultiplier,
      ),
      width: 60.0 * AppScale.widthMultiplier,
      child: TextField(
        obscureText: obscure,
        onChanged: ((value) => fun(value)),
        cursorColor: Colors.black,
        style: const TextStyle(color: kColorPrimary),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
