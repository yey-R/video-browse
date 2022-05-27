import 'package:flutter/material.dart';
import 'package:video_browse/utilities/constants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15.0,
        top: 15.0,
      ),
      alignment: Alignment.topLeft,
      child: GestureDetector(
        child: CircleAvatar(
          backgroundColor: kColorPrimary,
          child: Image.asset(
            "assets/icons/back.png",
            color: kColorOwnerText,
            width: 35.0,
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
