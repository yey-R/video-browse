import 'package:flutter/material.dart';

class LoadingBox extends StatelessWidget {
  const LoadingBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/3.gif",
      width: double.infinity,
      color: Colors.black,
      fit: BoxFit.cover,
    );
  }
}
