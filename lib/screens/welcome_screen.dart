import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_browse/firebase_options.dart';
import 'package:video_browse/screens/login_screen.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/widgets/action_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  void initFirebase() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppScale().init(context);
    initFirebase();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/background.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 35.0 * AppScale.heightMultiplier,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/app.gif",
                    height: 9.0 * AppScale.heightMultiplier,
                  ),
                  SizedBox(
                    width: 5.0 * AppScale.widthMultiplier,
                  ),
                  Image.asset(
                    "assets/icons/icon_app_name.png",
                    height: 5.5 * AppScale.heightMultiplier,
                  ),
                ],
              ),
              SizedBox(
                height: 28.0 * AppScale.heightMultiplier,
              ),
              ActionButton(
                buttonText: "Log in",
                routerPage: const LoginScreen(),
                replace: true,
                width: 37.0 * AppScale.widthMultiplier,
                fun: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
