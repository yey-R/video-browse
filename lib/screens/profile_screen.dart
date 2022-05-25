import 'package:flutter/material.dart';
import 'package:video_browse/screens/login_screen.dart';
import 'package:video_browse/screens/manage_video_screen.dart';
import 'package:video_browse/screens/upload_video_screen.dart';
import 'package:video_browse/services/fetch_user.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:video_browse/widgets/action_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);
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
            FetchUser().currentUser.getProfilePicture(flag: true),
            Text(
              "${FetchUser().currentUser.getUsername()}",
              style: const TextStyle(
                fontSize: 25.0,
                color: kColorOwnerText,
              ),
            ),
            const ActionButton(
              buttonText: "Upload a Video",
              routerPage: UploadVideoScreen(),
              replace: false,
              width: 200.0,
              fun: null,
            ),
            const ActionButton(
              buttonText: "Manage Your Videos",
              routerPage: ManageVideosScreen(),
              replace: false,
              width: 250.0,
              fun: null,
            ),
            ActionButton(
              buttonText: "Sign Out",
              routerPage: const LoginScreen(),
              replace: true,
              width: 200.0,
              fun: FetchUser().auth.signOut,
            )
          ],
        ),
      ),
    );
  }
}
