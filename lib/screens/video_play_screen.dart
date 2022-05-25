import 'package:flutter/material.dart';
import 'package:video_browse/models/comment.dart';
import 'package:video_browse/models/user.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/services/fetch_videos.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:chewie/chewie.dart';
import 'package:video_browse/widgets/input_box.dart';
import 'package:video_browse/widgets/video_play/comment_box.dart';
import 'package:video_browse/widgets/video_play/comment_section.dart';
import 'package:video_browse/widgets/video_play/description.dart';
import 'package:video_browse/widgets/video_play/recommend_box.dart';
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
  bool commentToggle = false;
  bool isComments = true;
  String comment = "";
  bool flag = true;
  TextEditingController controller = TextEditingController();

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
    commentToggle = widget.video.getCommentToggle();
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

  void updateSection(bool flag) {
    setState(() {
      isComments = flag;
    });
  }

  void updateCounter() {
    setState(() {});
  }

  List<CommentBox> getComments() {
    List<CommentBox> commentBox = <CommentBox>[];
    if (commentBox.isEmpty) {
      List<Comment> comments = widget.video.getComments();
      for (Comment comment in comments) {
        CommentBox box = CommentBox(
          info: comment,
        );
        commentBox.add(box);
      }
    }
    return commentBox;
  }

  List<RecommendBox> getReccommends() {
    List<VideoInfo> videos = FetchVideos().getVideos();
    List<RecommendBox> recVideos = <RecommendBox>[];
    for (VideoInfo video in videos) {
      if (widget.video.getCategory() == video.getCategory() &&
          widget.video.getID() != video.getID()) {
        recVideos.add(
          RecommendBox(
            info: video,
          ),
        );
      }
    }
    return recVideos;
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
            Description(
              video: widget.video,
              fun: updateCounter,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: kColorBoxBorder,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25.0,
                    ),
                    CommentSection(fun: updateSection, activeTitle: "Comments"),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Stack(
                        fit: StackFit.passthrough,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        children: [
                          commentToggle || !isComments
                              ? ListView(
                                  children: isComments
                                      ? getComments()
                                      : getReccommends(),
                                )
                              : Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/comments_off.png",
                                      width: 250.0,
                                      color: kColorPrimary,
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    const Text(
                                      "Comments are disabled by video creator",
                                      style: TextStyle(
                                        color: kColorVideoText,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                          isComments && commentToggle
                              ? Positioned(
                                  bottom: 0.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 300,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                        ),
                                        child: flag
                                            ? TextField(
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: kColorPrimary,
                                                ),
                                                textAlign: TextAlign.center,
                                                controller: controller,
                                                decoration: InputDecoration(
                                                  hintText: "Leave a comment",
                                                  filled: true,
                                                  fillColor: kColorInactive,
                                                  counterStyle: const TextStyle(
                                                    color: Colors.transparent,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    comment = value;
                                                  });
                                                },
                                              )
                                            : const SizedBox.shrink(),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                          isComments && commentToggle
                              ? Positioned(
                                  bottom: 5.0,
                                  right: 15.0,
                                  child: GestureDetector(
                                    child: CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: kColorActive,
                                      child: Image.asset(
                                        flag
                                            ? "assets/icons/check.png"
                                            : "assets/icons/write.png",
                                        width: 25.0,
                                        color: kColorPrimary,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (comment.isEmpty || !flag) {
                                          setState(() {
                                            flag = !flag;
                                          });
                                          return;
                                        }
                                        controller.clear();
                                        Comment tempComment =
                                            Comment(User(""), comment);
                                        widget.video.addComment(tempComment);
                                        comment = "";
                                      });
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
