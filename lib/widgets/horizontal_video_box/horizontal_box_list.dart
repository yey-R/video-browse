import 'package:flutter/material.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/services/fetch_user.dart';
import 'package:video_browse/services/fetch_videos.dart';
import 'package:video_browse/widgets/horizontal_video_box/horizontal_video_box.dart';

class HorizontalBoxList extends StatelessWidget {
  final dynamic fun;
  const HorizontalBoxList({
    Key? key,
    this.fun,
  }) : super(key: key);

  List<HorizontalBox> createVideos() {
    List<VideoInfo> videoList = FetchVideos().getVideos();
    List<HorizontalBox> userVideos = <HorizontalBox>[];
    for (VideoInfo video in videoList) {
      if (video.getOwner().getUID() == FetchUser().uid) {
        HorizontalBox box = HorizontalBox(
          info: video,
          isEditable: true,
          fun: fun,
        );
        userVideos.add(box);
      }
    }
    return userVideos;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        children: createVideos(),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 100,
    );
  }
}
