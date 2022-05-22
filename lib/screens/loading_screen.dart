import 'package:flutter/material.dart';
import 'package:video_browse/screens/login_screen.dart';
import 'package:video_browse/screens/main_screen.dart';
import 'package:video_browse/services/fetch_categories.dart';
import 'package:video_browse/services/fetch_login.dart';
import 'package:video_browse/services/fetch_videos.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class LoadingScreen extends StatefulWidget {
  final String email;
  final String password;
  const LoadingScreen({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    fetchLogin();
  }

  void fetchLogin() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FetchLogin login = FetchLogin(widget.email, widget.password);
    dynamic isLoggedIn = await login.checkAuth();
    if (!isLoggedIn) {
      await FetchVideos().setVideos();
      await FetchCategories().setCategories();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const MainScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPrimary,
      body: Center(
        child: Image.asset(
          "assets/2.gif",
          width: 150.0,
        ),
      ),
    );
  }
}
