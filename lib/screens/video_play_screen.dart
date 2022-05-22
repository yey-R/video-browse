import 'package:flutter/material.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:chewie/chewie.dart';
import 'package:video_browse/widgets/video_list/info_box.dart';
import 'package:video_player/video_player.dart';

class VideoPlayScreen extends StatefulWidget {
  final VideoInfo video;
  const VideoPlayScreen({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  dynamic videoPlayerController;
  dynamic chewieController;
  dynamic playerWidget;
  double _height = 120.0;

  Widget placeHolder = Image.asset(
    "assets/3.gif",
    width: double.infinity,
    color: Colors.black,
    fit: BoxFit.cover,
  );

  @override
  void initState() {
    super.initState();
    createVideoPlayer();
  }

  void createVideoPlayer() async {
    videoPlayerController =
        VideoPlayerController.network(widget.video.getURL());

    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      autoPlay: true,
      looping: false,
    );

    setState(
      () {
        placeHolder = Chewie(
          controller: chewieController,
        );
      },
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPrimary,
      body: SafeArea(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                height: 300,
                width: double.infinity,
                child: placeHolder,
              ),
            ),
            AnimatedContainer(
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
                color: kColorBoxBorder,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
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
                      ),
                      InfoBox(
                        icon: "assets/icons/like.png",
                        value: widget.video.getLikes(),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: Text(
                      "DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription",
                      softWrap: true,
                      style: TextStyle(
                        color: kColorOwnerText,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Icon(
                      _height == 100
                          ? Icons.arrow_drop_down
                          : Icons.arrow_drop_up,
                      color: kColorOwnerText,
                      size: 30.0,
                    ),
                    onTap: () {
                      setState(() {
                        _height = _height == 200.0 ? 115.0 : 200.0;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
