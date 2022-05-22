import 'package:flutter/material.dart';
import 'package:video_browse/utilities/constants.dart';

class NavigationBarButton extends StatelessWidget {
  final bool hasIcon;
  final String title;
  final dynamic routerPage;
  final String iconName;
  const NavigationBarButton({
    Key? key,
    required this.hasIcon,
    required this.iconName,
    required this.title,
    required this.routerPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => routerPage,
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hasIcon
                ? Image.asset(
                    "assets/icons/$iconName.png",
                    color: kColorActive,
                    width: 20.0,
                  )
                : const SizedBox.shrink(),
            hasIcon ? const SizedBox(width: 4.0) : const SizedBox.shrink(),
            Text(
              title,
              style: TextStyle(
                color: hasIcon ? kColorActive : kColorInactive,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
