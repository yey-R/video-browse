import 'package:flutter/material.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/screens/video_play_screen.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/video_list/info_box.dart';

class VideoBox extends StatelessWidget {
  final VideoInfo video;

  const VideoBox({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 14.0,
        horizontal: 6.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20.0,
                child: Icon(
                  Icons.person,
                ),
              ),
              const SizedBox(
                width: 6.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.getName(),
                    style: const TextStyle(
                      color: kColorOwnerText,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    video.getOwner(),
                    style: const TextStyle(
                      color: kColorVideoText,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 6.0,
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        VideoPlayScreen(
                      video: video,
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
                  height: 200,
                  width: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 6.0,
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
                width: video.getCommentToggle() ? 4.0 : 0,
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
            margin: const EdgeInsets.only(top: 18.0, left: 12.0, right: 12.0),
            width: double.infinity,
            height: 2,
            color: kColorBoxBorder,
          ),
        ],
      ),
    );
  }
}
