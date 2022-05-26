import 'package:flutter/material.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/screens/video_play_screen.dart';
import 'package:video_browse/utilities/constants.dart';

class RecommendBox extends StatelessWidget {
  final VideoInfo info;
  final dynamic fun;
  const RecommendBox({
    Key? key,
    required this.info,
    this.fun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                info.getThumbnail(),
                height: 100,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.getName(),
                    style: const TextStyle(
                      color: kColorOwnerText,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    info.getOwner().getUsername(),
                    style: const TextStyle(
                      color: kColorVideoText,
                      fontSize: 15.0,
                    ),
                  ),
                  Text(
                    "${info.getDate()} · ${info.getView()} views",
                    style: const TextStyle(
                      color: kColorVideoText,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => VideoPlayScreen(
              video: info,
              fun: fun,
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
    );
  }
}
