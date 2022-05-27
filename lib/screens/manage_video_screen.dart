import 'package:flutter/material.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/horizontal_video_box/horizontal_box_list.dart';

class ManageVideosScreen extends StatefulWidget {
  const ManageVideosScreen({Key? key}) : super(key: key);

  @override
  State<ManageVideosScreen> createState() => _ManageVideosScreenState();
}

class _ManageVideosScreenState extends State<ManageVideosScreen> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Container(
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
            ),
            HorizontalBoxList(fun: update),
          ],
        ),
      ),
    );
  }
}
