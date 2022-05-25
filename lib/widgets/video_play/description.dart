import 'package:flutter/material.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/video_list/info_box.dart';

class Description extends StatefulWidget {
  final VideoInfo video;
  final Function fun;
  const Description({
    Key? key,
    required this.video,
    required this.fun,
  }) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  dynamic _height;
  @override
  void initState() {
    super.initState();
    widget.video.increaseView();
    _height = widget.video.getDesc().length > 35 ? 110.0 : 100.0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      height: _height,
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 10.0,
        left: 15.0,
        right: 15.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.video.getName(),
                    style: const TextStyle(
                      color: kColorOwnerText,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.video.getOwner(),
                    style: const TextStyle(
                      color: kColorVideoText,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              InfoBox(
                icon: "assets/icons/view.png",
                value: widget.video.getView(),
                isMainPage: false,
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                child: InfoBox(
                  icon: "assets/icons/like.png",
                  value: widget.video.getLikes(),
                  isMainPage: false,
                ),
                onTap: () {
                  setState(() {
                    widget.video.increaseLike();
                    widget.fun();
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.video.getDesc(),
                softWrap: true,
                style: const TextStyle(
                  color: kColorOwnerText,
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          widget.video.getDesc().length > 35
              ? GestureDetector(
                  child: Icon(
                    _height == 110
                        ? Icons.arrow_drop_down
                        : Icons.arrow_drop_up,
                    color: kColorOwnerText,
                    size: 30.0,
                  ),
                  onTap: () {
                    setState(() {
                      _height = _height == 145.0 ? 110.0 : 145.0;
                    });
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
