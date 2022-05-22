import 'package:flutter/material.dart';
import 'package:video_browse/utilities/constants.dart';

class InfoBox extends StatefulWidget {
  final String icon;
  final int value;
  const InfoBox({
    Key? key,
    required this.icon,
    required this.value,
  }) : super(key: key);

  @override
  State<InfoBox> createState() => _InfoBoxState();
}

class _InfoBoxState extends State<InfoBox> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            widget.icon,
            width: 30.0,
            color: kColorActive,
          ),
          const SizedBox(
            width: 3.0,
          ),
          Text(
            "${widget.value}",
            style: const TextStyle(
              color: Color(0xFF959595),
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
