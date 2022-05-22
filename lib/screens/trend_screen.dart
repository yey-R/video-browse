import 'package:flutter/material.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';

class TrendScreen extends StatelessWidget {
  const TrendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(
        isTrends: true,
      ),
      backgroundColor: kColorPrimary,
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
