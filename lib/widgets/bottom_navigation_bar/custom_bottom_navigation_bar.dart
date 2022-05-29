import 'package:flutter/material.dart';
import 'package:video_browse/screens/main_screen.dart';
import 'package:video_browse/screens/profile_screen.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/widgets/bottom_navigation_bar/navigation_bar_button.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final bool isHome;
  final bool isProfile;
  const CustomBottomNavigationBar({
    Key? key,
    this.isHome = false,
    this.isProfile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.8 * AppScale.heightMultiplier,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xFF424242),
        borderRadius: BorderRadius.all(
          Radius.circular(
            5.0 * AppScale.heightMultiplier,
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
            hasIcon: isProfile,
            iconName: "profile",
            title: "Profile",
            routerPage: const ProfileScreen(),
          ),
        ],
      ),
    );
  }
}
