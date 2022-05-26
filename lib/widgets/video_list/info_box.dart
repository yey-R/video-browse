import 'package:flutter/material.dart';
import 'package:video_browse/utilities/constants.dart';

class InfoBox extends StatelessWidget {
  final String icon;
  final int value;
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
          width: isMainPage ? 18.0 : 30.0,
          color: isLiked ? Colors.red : kColorActive,
        ),
        const SizedBox(
          width: 3.0,
        ),
        Text(
          "$value",
          style: const TextStyle(
            color: Color(0xFF959595),
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
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
