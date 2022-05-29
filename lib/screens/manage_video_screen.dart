import 'package:flutter/material.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/custom_back_button.dart';
import 'package:video_browse/widgets/video_box/horizontal_box/horizontal_box_list.dart';

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
            const CustomBackButton(),
            HorizontalBoxList(fun: update),
          ],
        ),
      ),
    );
  }
}
