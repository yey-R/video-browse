import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_browse/services/create_user.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/action_button.dart';
import 'package:video_browse/widgets/input_box/login_input_box.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  dynamic email;
  dynamic password;
  dynamic username;
  dynamic profilePic;
  bool validEmail = true;
  bool validPassword = true;
  bool validUsername = true;
  dynamic register;

  @override
  void initState() {
    super.initState();
    register = CreateUser(
      fun: showError,
    );
  }

  void setPassword(String password) {
    this.password = password;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setUsername(String username) {
    this.username = username;
  }

  void showError(String credential) {
    setState(() {
      validEmail = validPassword = validUsername = true;
      if (credential == "username") {
        validUsername = false;
      } else if (credential == "email") {
        validEmail = false;
      } else if (credential == "password") {
        validPassword = false;
      }
    });
  }

  void createUser() async {
    if (!register.checkCredentials(email, username, password)) return;
    try {
      await register.createUser();
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showError("email");
      }
    } on Exception {
      showError("username");
    }
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
                GestureDetector(
                  child: CircleAvatar(
                    child: profilePic == null
                        ? const Icon(
                            Icons.person,
                            color: Colors.white,
                          )
                        : null,
                    backgroundColor: kColorActive,
                    radius: 5.5 * AppScale.heightMultiplier,
                    backgroundImage: profilePic,
                  ),
                  onTap: () async {
                    dynamic pic = await register.pickProfilePicture();
                    if (pic != null) {
                      setState(() {
                        profilePic = FileImage(File(pic));
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 1.7 * AppScale.heightMultiplier,
                ),
                LoginInputBox(
                  fun: setUsername,
                  hint: "Username",
                ),
                LoginInputBox(
                  fun: setEmail,
                  hint: "Email",
                ),
                LoginInputBox(
                  fun: setPassword,
                  hint: "Password",
                  obscure: true,
                ),
                ActionButton(
                  buttonText: "Sign Up",
                  routerPage: null,
                  replace: false,
                  width: 40.0 * AppScale.widthMultiplier,
                  fun: createUser,
                ),
                validEmail
                    ? const SizedBox.shrink()
                    : const Text(
                        invalidEmail,
                        style: TextStyle(color: kColorOwnerText),
                      ),
                validPassword
                    ? const SizedBox.shrink()
                    : const Text(
                        invalidPassword,
                        style: TextStyle(color: kColorOwnerText),
                      ),
                validUsername
                    ? const SizedBox.shrink()
                    : const Text(
                        invalidUsername,
                        style: TextStyle(color: kColorOwnerText),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
