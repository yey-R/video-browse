import 'package:flutter/material.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';

class CommentSection extends StatefulWidget {
  final Function fun;
  final String activeTitle;
  const CommentSection({
    Key? key,
    required this.fun,
    required this.activeTitle,
  }) : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final List<String> titles = ["Comments", "Guess you like"];
  List<Widget> buttons = <Widget>[];
  String activeTitle = "";

  @override
  void initState() {
    super.initState();
    activeTitle = widget.activeTitle;
  }

  void createButtons() {
    buttons.clear();
    for (String title in titles) {
      Widget button = GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 4.9 * AppScale.widthMultiplier,
          ),
          height: 6.0 * AppScale.heightMultiplier,
          padding: EdgeInsets.symmetric(
            horizontal: 2.4 * AppScale.widthMultiplier,
            vertical: 1.1 * AppScale.heightMultiplier,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: title == activeTitle ? kColorBoxBorder : kColorInactive,
                fontSize: 2.2 * AppScale.textMultiplier,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: title == activeTitle ? kColorActive : Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(3.3 * AppScale.heightMultiplier),
            ),
          ),
        ),
        onTap: () {
          widget.fun(title == "Comments");
          setState(() {
            activeTitle = title;
            buttons.clear();
            createButtons();
          });
        },
      );
      buttons.add(button);
    }
  }

  @override
  Widget build(BuildContext context) {
    createButtons();
    return Row(
      children: buttons,
    );
  }
}
