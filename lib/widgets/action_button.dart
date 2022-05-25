import 'package:flutter/material.dart';
import 'package:video_browse/utilities/constants.dart';

// ignore: must_be_immutable
class ActionButton extends StatelessWidget {
  final dynamic routerPage;
  final String buttonText;
  final bool replace;
  final double width;
  final dynamic fun;
  const ActionButton({
    Key? key,
    required this.buttonText,
    required this.routerPage,
    required this.replace,
    required this.width,
    required this.fun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width,
        height: 50,
        margin: const EdgeInsets.only(
          right: 12.0,
          left: 12.0,
          top: 6.0,
          bottom: 10.0,
        ),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: kColorActive,
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: kColorPrimary,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
      onTap: () {
        if (fun != null) {
          fun();
        }
        if (routerPage != null) {
          replace
              ? Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        routerPage,
                  ),
                )
              : Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        routerPage,
                  ),
                );
        }
      },
    );
  }
}
