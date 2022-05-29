import 'package:flutter/material.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/screens/video_play_screen.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/video_box/info_box.dart';

class VerticalBox extends StatelessWidget {
  final VideoInfo video;
  final Function fun;

  const VerticalBox({
    Key? key,
    required this.video,
    required this.fun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 1.6 * AppScale.heightMultiplier,
        horizontal: 1.5 * AppScale.widthMultiplier,
      ),
      child: Column(
        children: [
          Row(
            children: [
              video.user.getProfilePicture(),
              SizedBox(
                width: 1.5 * AppScale.widthMultiplier,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.getName(),
                    style: TextStyle(
                      color: kColorOwnerText,
                      fontSize: 2.0 * AppScale.heightMultiplier,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    video.getOwner().getUsername(),
                    style: TextStyle(
                      color: kColorVideoText,
                      fontSize: 1.7 * AppScale.textMultiplier,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 0.7 * AppScale.heightMultiplier,
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: GestureDetector(
              onTap: () {
                fun();
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        VideoPlayScreen(
                      video: video,
                      fun: fun,
                    ),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.network(
                  video.getThumbnail(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0.7 * AppScale.heightMultiplier,
          ),
          Row(
            children: [
              InfoBox(
                icon: "assets/icons/view.png",
                value: video.getView(),
                isMainPage: true,
              ),
              Expanded(
                child: Container(),
              ),
              InfoBox(
                icon: "assets/icons/like.png",
                value: video.getLikes(),
                isMainPage: true,
              ),
              SizedBox(
                width: video.getCommentToggle()
                    ? 1.0 * AppScale.widthMultiplier
                    : 0,
              ),
              video.getCommentToggle()
                  ? InfoBox(
                      icon: "assets/icons/comments.png",
                      value: video.getComments().length,
                      isMainPage: true,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 2.0 * AppScale.heightMultiplier,
              left: 2.9 * AppScale.widthMultiplier,
              right: 2.9 * AppScale.widthMultiplier,
            ),
            width: double.infinity,
            height: 0.23 * AppScale.heightMultiplier,
            color: kColorBoxBorder,
          ),
        ],
      ),
    );
  }
}
