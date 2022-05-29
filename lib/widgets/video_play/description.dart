import 'package:flutter/material.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/services/fetch_user.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/video_box/info_box.dart';

class Description extends StatefulWidget {
  final VideoInfo video;
  final dynamic fun;
  const Description({
    Key? key,
    required this.video,
    this.fun,
  }) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  dynamic _height;
  dynamic _isLiked;
  @override
  void initState() {
    super.initState();
    _height = widget.video.getDesc().length > 35
        ? 12.2 * AppScale.heightMultiplier
        : 11.1 * AppScale.heightMultiplier;
    _isLiked = widget.video.isLiked(FetchUser().uid);
  }

  void update() async {
    await widget.video.updateLike(FetchUser().uid);
    setState(() {
      _isLiked = widget.video.isLiked(FetchUser().uid);
    });
    if (widget.fun != null) widget.fun();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      height: _height,
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 1.1 * AppScale.heightMultiplier,
        left: 3.65 * AppScale.widthMultiplier,
        right: 3.65 * AppScale.widthMultiplier,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.1 * AppScale.widthMultiplier),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(3.3 * AppScale.heightMultiplier),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.video.getOwner().getProfilePicture(),
              SizedBox(
                width: 1.45 * AppScale.widthMultiplier,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.video.getName(),
                    style: TextStyle(
                      color: kColorOwnerText,
                      fontSize: 2.0 * AppScale.textMultiplier,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.video.getOwner().getUsername(),
                    style: TextStyle(
                      color: kColorVideoText,
                      fontSize: 1.7 * AppScale.textMultiplier,
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
              SizedBox(
                width: 2.4 * AppScale.widthMultiplier,
              ),
              GestureDetector(
                child: InfoBox(
                  icon: "assets/icons/like.png",
                  value: widget.video.getLikes(),
                  isMainPage: false,
                  isLiked: _isLiked,
                ),
                onTap: () {
                  update();
                },
              ),
            ],
          ),
          SizedBox(
            height: 1.1 * AppScale.heightMultiplier,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.video.getDesc(),
                softWrap: true,
                style: TextStyle(
                  color: kColorOwnerText,
                  fontSize: 1.7 * AppScale.textMultiplier,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          widget.video.getDesc().length > 35
              ? GestureDetector(
                  child: Icon(
                    _height == 12.2 * AppScale.heightMultiplier
                        ? Icons.arrow_drop_down
                        : Icons.arrow_drop_up,
                    color: kColorOwnerText,
                    size: 3.3 * AppScale.heightMultiplier,
                  ),
                  onTap: () {
                    setState(() {
                      _height = _height == 16.1 * AppScale.heightMultiplier
                          ? 12.2 * AppScale.heightMultiplier
                          : 16.1 * AppScale.heightMultiplier;
                    });
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
