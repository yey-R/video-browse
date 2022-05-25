import 'package:flutter/material.dart';
import 'package:video_browse/models/comment.dart';
import 'package:video_browse/utilities/constants.dart';

class CommentBox extends StatelessWidget {
  final Comment info;
  const CommentBox({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          width: double.infinity,
          height: 55.0,
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                child: info.getOwner().getProfilePicture(),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.getOwner().getUsername(),
                    style: const TextStyle(
                      color: kColorOwnerText,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    info.getDate().toString().substring(0, 16),
                    style: const TextStyle(
                      color: kColorVideoText,
                      fontSize: 12.0,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
          margin: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          width: double.infinity,
          height: 1,
          color: kColorInactive,
        ),
      ],
    );
  }
}
