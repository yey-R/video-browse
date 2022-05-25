import 'package:flutter/material.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/video_play/comment_box.dart';

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
    createButtons();
  }

  void createButtons() {
    for (String title in titles) {
      Widget button = GestureDetector(
        child: Container(
          margin: const EdgeInsets.only(left: 20.0),
          height: 43.0,
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: TextStyle(
              color: title == activeTitle ? kColorBoxBorder : kColorInactive,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          decoration: BoxDecoration(
            color: title == activeTitle ? kColorActive : Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(30.0),
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
    return Row(
      children: buttons,
    );
  }
}
