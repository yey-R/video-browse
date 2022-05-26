import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_browse/services/create_user.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/action_button.dart';

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

  void showError(String credential) {
    setState(() {
      validEmail = validPassword = validUsername = true;
      if (credential == "email") {
        validEmail = false;
      } else if (credential == "password") {
        validPassword = false;
      } else if (credential == "username") {
        validUsername = false;
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
                    radius: 50,
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
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: 250.0,
                  child: TextField(
                    onChanged: ((value) => username = value),
                    cursorColor: Colors.black,
                    style: const TextStyle(color: kColorPrimary),
                    decoration: InputDecoration(
                      hintText: "Username",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: 250.0,
                  child: TextField(
                    onChanged: ((value) => email = value),
                    cursorColor: Colors.black,
                    style: const TextStyle(color: kColorPrimary),
                    decoration: InputDecoration(
                      hintText: "E-Mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: 250.0,
                  child: TextField(
                    obscureText: true,
                    onChanged: ((value) => password = value),
                    cursorColor: Colors.black,
                    style: const TextStyle(color: kColorPrimary),
                    decoration: InputDecoration(
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                ActionButton(
                  buttonText: "Sign Up",
                  routerPage: null,
                  replace: false,
                  width: 170,
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
