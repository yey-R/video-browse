import 'package:flutter/material.dart';
import 'package:video_browse/models/category.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/widgets/video_list/video_box.dart';

class VideoList extends StatelessWidget {
  final Category category;
  final List<VideoInfo> videos;
  final Function fun;
  final List<VideoBox> videoList = <VideoBox>[];

  VideoList({
    Key? key,
    required this.category,
    required this.videos,
    required this.fun,
  }) : super(key: key) {
    createVideos();
  }

  void createVideos() {
    for (VideoInfo info in videos) {
      VideoBox video = VideoBox(
        video: info,
        fun: fun,
      );
      videoList.add(video);
    }
  }

  List<VideoBox> filterVideos(Category category) {
    if (category.getCategory() == "All") {
      return videoList;
    } else {
      List<VideoBox> temp = <VideoBox>[];
      for (VideoBox videoBox in videoList) {
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
