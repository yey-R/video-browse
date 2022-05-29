import 'package:flutter/material.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';

class ActionButton extends StatelessWidget {
  final dynamic routerPage;
  final dynamic buttonText;
  final dynamic fun;
  final dynamic buttonImage;
  final bool replace;
  final double width;

  const ActionButton({
    Key? key,
    required this.routerPage,
    required this.replace,
    required this.width,
    required this.fun,
    this.buttonText,
    this.buttonImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: buttonImage ??
          Container(
            width: width,
            height: 5.5 * AppScale.heightMultiplier,
            margin: EdgeInsets.only(
              right: 3.0 * AppScale.widthMultiplier,
              left: 3.0 * AppScale.widthMultiplier,
              top: 0.75 * AppScale.heightMultiplier,
              bottom: 1.1 * AppScale.heightMultiplier,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 1.1 * AppScale.heightMultiplier,
              horizontal: 2.5 * AppScale.widthMultiplier,
            ),
            decoration: const BoxDecoration(
              color: kColorActive,
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: kColorPrimary,
                  fontSize: 2.1 * AppScale.textMultiplier,
                ),
              ),
            ),
          ),
      onTap: () async {
        if (fun != null) {
          await fun();
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
