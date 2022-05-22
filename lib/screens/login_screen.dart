import 'package:flutter/material.dart';
import 'package:video_browse/widgets/login/login_button.dart';
import 'package:video_browse/widgets/login/login_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/8.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          !isLogin
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 310,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/2.gif",
                          width: 100,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          "assets/icons/icon_app_name.png",
                          width: 150,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 250,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = true;
                        });
                      },
                      child: const LoginButton(buttonText: "Log in"),
                    ),
                  ],
                )
              : const LoginInput(),
        ],
      ),
    );
  }
}
