import 'package:flutter/material.dart';
import 'package:video_browse/models/video_info.dart';

class TrendBox extends StatelessWidget {
  final VideoInfo video;
  const TrendBox({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 2.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Image.asset(
              "assets/video.png",
              height: 180,
              width: 340,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 4.0,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.person,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(video.getName()),
                    Text(
                      "${video.getOwner()} · ${video.getView()} views · ${video.getUploadDate()} days ago",
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
