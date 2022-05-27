import 'package:flutter/material.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/screens/video_play_screen.dart';
import 'package:video_browse/services/remove_video.dart';
import 'package:video_browse/utilities/constants.dart';

class HorizontalBox extends StatelessWidget {
  final VideoInfo info;
  final dynamic fun;
  final bool isEditable;

  const HorizontalBox({
    Key? key,
    required this.info,
    this.fun,
    this.isEditable = false,
  }) : super(key: key);

  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove the video?'),
            actions: [
              TextButton(
                onPressed: () async {
                  await RemoveVideo().removeVideo(info);
                  fun();
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Row(
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
            Positioned(
              right: 15.0,
              child: GestureDetector(
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onTap: () {
                  _delete(context);
                },
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
