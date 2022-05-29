import 'package:flutter/material.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 3.65 * AppScale.widthMultiplier,
        top: 1.65 * AppScale.heightMultiplier,
      ),
      alignment: Alignment.topLeft,
      child: GestureDetector(
        child: CircleAvatar(
          backgroundColor: kColorPrimary,
          child: Image.asset(
            "assets/icons/back.png",
            color: kColorOwnerText,
            width: 8.5 * AppScale.widthMultiplier,
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
