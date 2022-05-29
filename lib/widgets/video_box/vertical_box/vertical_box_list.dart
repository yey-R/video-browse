import 'package:flutter/material.dart';
import 'package:video_browse/models/category.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/widgets/video_box/vertical_box/vertical_box.dart';

class VerticalBoxList extends StatelessWidget {
  final Category category;
  final List<VideoInfo> videos;
  final Function fun;
  final List<VerticalBox> videoList = <VerticalBox>[];

  VerticalBoxList({
    Key? key,
    required this.category,
    required this.videos,
    required this.fun,
  }) : super(key: key) {
    createVideos();
  }

  void createVideos() {
    for (VideoInfo info in videos) {
      VerticalBox video = VerticalBox(
        video: info,
        fun: fun,
      );
      videoList.add(video);
    }
  }

  List<VerticalBox> filterVideos(Category category) {
    if (category.getCategory() == "All") {
      return videoList;
    } else {
      List<VerticalBox> temp = <VerticalBox>[];
      for (VerticalBox videoBox in videoList) {
        if (videoBox.video.getCategory() == category.getCategory()) {
          temp.add(videoBox);
        }
      }
      return temp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: filterVideos(category),
      ),
    );
  }
}
