import 'package:flutter/material.dart';
import 'package:video_browse/screens/loading_screen.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/action_button.dart';
import 'package:video_browse/widgets/input_box/login_input_box.dart';
import 'package:video_browse/widgets/sign_up_button.dart';

class LoginScreen extends StatefulWidget {
  final bool hasError;
  const LoginScreen({Key? key, this.hasError = false}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  dynamic email;
  dynamic password;
  dynamic hasError;

  @override
  void initState() {
    super.initState();
    hasError = widget.hasError;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void login() {
    if (email == null && password == null) {
      setState(() {
        hasError = true;
      });
      return;
    }
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            LoadingScreen(email: email, password: password),
      ),
    );
  }

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
                  "assets/background.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/app.gif",
                  width: 25.0 * AppScale.widthMultiplier,
                ),
                LoginInputBox(
                  fun: setEmail,
                  hint: "E-Mail",
                ),
                LoginInputBox(
                  fun: setPassword,
                  hint: "Password",
                  obscure: true,
                ),
                const SignUpButton(),
                ActionButton(
                  buttonText: "Log in",
                  routerPage: null,
                  replace: true,
                  width: 37.0 * AppScale.widthMultiplier,
                  fun: login,
                ),
                hasError
                    ? const Text(
                        wrongCredit,
                        style: TextStyle(color: kColorOwnerText),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
