import 'package:flutter/material.dart';
import 'package:video_browse/utilities/app_scale.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  CustomAppBar({
    Key? key,
    required this.height,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SizedBox(
        height: 8.9 * AppScale.heightMultiplier,
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 8.9 * AppScale.heightMultiplier,
              alignment: Alignment.centerLeft,
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 2.4 * AppScale.widthMultiplier,
                    ),
                    Image.asset(
                      'assets/2.gif',
                      height: 25.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Image.asset(
                        'assets/icons/icon_app_name.png',
                        width: 70.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
