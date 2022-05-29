import 'package:flutter/material.dart';
import 'package:video_browse/models/comment.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';

class CommentBox extends StatelessWidget {
  final Comment info;
  const CommentBox({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 4.9 * AppScale.widthMultiplier,
          ),
          width: double.infinity,
          height: 6.1 * AppScale.heightMultiplier,
          child: Row(
            children: [
              CircleAvatar(
                radius: 2.2 * AppScale.heightMultiplier,
                child: info.getOwner().getProfilePicture(),
              ),
              SizedBox(
                width: 2.4 * AppScale.widthMultiplier,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.getOwner().getUsername(),
                    style: TextStyle(
                      color: kColorOwnerText,
                      fontSize: 2.0 * AppScale.textMultiplier,
                    ),
                  ),
                  Text(
                    info.getDate(),
                    style: TextStyle(
                      color: kColorVideoText,
                      fontSize: 1.4 * AppScale.textMultiplier,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 1.1 * AppScale.heightMultiplier,
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 4.9 * AppScale.widthMultiplier,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            info.getComment(),
            style: const TextStyle(
              color: kColorOwnerText,
            ),
            softWrap: true,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 4.9 * AppScale.widthMultiplier,
            vertical: 1.1 * AppScale.heightMultiplier,
          ),
          width: double.infinity,
          height: 0.11 * AppScale.heightMultiplier,
          color: kColorInactive,
        ),
      ],
    );
  }
}
