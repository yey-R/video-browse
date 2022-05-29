import 'package:flutter/material.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/screens/video_play_screen.dart';
import 'package:video_browse/services/remove_video.dart';
import 'package:video_browse/utilities/app_scale.dart';
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
            content: const Text('Are you sure to remove this video?'),
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
        margin: EdgeInsets.symmetric(
          horizontal: 2.4 * AppScale.widthMultiplier,
          vertical: 1.1 * AppScale.heightMultiplier,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    info.getThumbnail(),
                    height: 11.1 * AppScale.heightMultiplier,
                    width: 48.6 * AppScale.widthMultiplier,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 2.45 * AppScale.widthMultiplier,
                ),
                SizedBox(
                  height: 11.1 * AppScale.heightMultiplier,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info.getName(),
                        style: TextStyle(
                          color: kColorOwnerText,
                          fontSize: 2.0 * AppScale.textMultiplier,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        info.getOwner().getUsername(),
                        style: TextStyle(
                          color: kColorVideoText,
                          fontSize: 1.7 * AppScale.heightMultiplier,
                        ),
                      ),
                      Text(
                        "${info.getView()} views · ${info.getDate()}",
                        style: TextStyle(
                          color: kColorVideoText,
                          fontSize: 1.7 * AppScale.heightMultiplier,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 3.65 * AppScale.widthMultiplier,
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
