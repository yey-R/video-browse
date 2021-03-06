import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_browse/firebase_options.dart';
import 'package:video_browse/screens/login_screen.dart';
import 'package:video_browse/screens/main_screen.dart';
import 'package:video_browse/services/fetch_categories.dart';
import 'package:video_browse/services/fetch_login.dart';
import 'package:video_browse/services/fetch_user.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';

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
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    FetchLogin login = FetchLogin(widget.email, widget.password);
    dynamic isLoggedIn = await login.checkAuth();
    if (isLoggedIn) {
      await FetchCategories().setCategories();
      await FetchUser().setUser();
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
          pageBuilder: (context, animation1, animation2) => const LoginScreen(
            hasError: true,
          ),
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
          "assets/app.gif",
          width: 36.5 * AppScale.widthMultiplier,
        ),
      ),
    );
  }
}
