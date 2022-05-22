import 'package:flutter/material.dart';
import 'package:video_browse/screens/main_screen.dart';
import 'package:video_browse/screens/trend_screen.dart';
import 'package:video_browse/screens/upload_video_screen.dart';
import 'package:video_browse/widgets/bottom_navigation_bar/navigation_bar_button.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final bool isHome;
  final bool isTrends;
  final bool isProfile;
  const CustomBottomNavigationBar({
    Key? key,
    this.isHome = false,
    this.isProfile = false,
    this.isTrends = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color(0xFF424242),
        borderRadius: BorderRadius.all(
          Radius.circular(
            45,
          ),
        ),
      ),
      child: Row(
        children: [
          NavigationBarButton(
            hasIcon: isHome,
            iconName: "home",
            title: "Home",
            routerPage: const MainScreen(),
          ),
          NavigationBarButton(
              hasIcon: isTrends,
              iconName: "trends",
              title: "Trends",
              routerPage: const TrendScreen()),
          NavigationBarButton(
              hasIcon: isProfile,
              iconName: "profile",
              title: "Profile",
              routerPage: const UploadVideoScreen()),
        ],
      ),
    );
  }
}
