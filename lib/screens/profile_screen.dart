import 'package:flutter/material.dart';
import 'package:video_browse/screens/login_screen.dart';
import 'package:video_browse/screens/manage_video_screen.dart';
import 'package:video_browse/screens/upload_video_screen.dart';
import 'package:video_browse/services/fetch_user.dart';
import 'package:video_browse/services/fetch_videos.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:video_browse/widgets/action_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  void signOut() async {
    await FetchUser().auth.signOut();
    FetchUser().reset();
    FetchVideos().reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(
        isProfile: true,
      ),
      backgroundColor: kColorPrimary,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FetchUser().currentUser.getProfilePicture(isBig: true),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 1.3 * AppScale.heightMultiplier,
              ),
              child: Text(
                "${FetchUser().currentUser.getUsername()}",
                style: TextStyle(
                  fontSize: 2.8 * AppScale.heightMultiplier,
                  color: kColorOwnerText,
                ),
              ),
            ),
            ActionButton(
              buttonText: "Upload a Video",
              routerPage: const UploadVideoScreen(),
              replace: false,
              width: 48.7 * AppScale.widthMultiplier,
              fun: null,
            ),
            ActionButton(
              buttonText: "Manage Your Own Content",
              routerPage: const ManageVideosScreen(),
              replace: false,
              width: 68.1 * AppScale.widthMultiplier,
              fun: null,
            ),
            ActionButton(
              buttonText: "Sign Out",
              routerPage: const LoginScreen(),
              replace: true,
              width: 36.5 * AppScale.widthMultiplier,
              fun: signOut,
            ),
          ],
        ),
      ),
    );
  }
}
