import 'package:flutter/material.dart';
import 'package:video_browse/models/category.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/widgets/video_list/video_box.dart';

class VideoList extends StatefulWidget {
  final Category category;
  final List<VideoInfo> videos;

  const VideoList({
    Key? key,
    required this.category,
    required this.videos,
  }) : super(key: key);

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  List<VideoBox> videoList = <VideoBox>[];

  @override
  void initState() {
    super.initState();
    createVideos();
  }

  void createVideos() {
    for (VideoInfo info in widget.videos) {
      VideoBox video = VideoBox(video: info);
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
        children: filterVideos(widget.category),
      ),
    );
  }
}
