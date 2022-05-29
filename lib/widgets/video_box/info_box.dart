import 'package:flutter/material.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';

class InfoBox extends StatelessWidget {
  final String icon;
  final dynamic value;
  final bool isMainPage;
  final List<Widget> widgets = [];
  final bool isLiked;

  InfoBox({
    Key? key,
    required this.icon,
    required this.value,
    required this.isMainPage,
    this.isLiked = false,
  }) : super(key: key) {
    widgets.addAll(
      [
        Image.asset(
          icon,
          width: isMainPage
              ? 4.4 * AppScale.widthMultiplier
              : 7.2 * AppScale.widthMultiplier,
          color: isLiked ? Colors.red : kColorActive,
        ),
        SizedBox(
          width: 0.7 * AppScale.widthMultiplier,
        ),
        Text(
          "$value",
          style: TextStyle(
            color: const Color(0xFF959595),
            fontWeight: FontWeight.bold,
            fontSize: 1.7 * AppScale.textMultiplier,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kColorBoxBorder,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: isMainPage
          ? Row(
              children: widgets,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets,
            ),
    );
  }
}
