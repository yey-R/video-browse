import 'package:flutter/material.dart';
import 'package:video_browse/models/comment.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/services/fetch_user.dart';
import 'package:video_browse/services/fetch_videos.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:chewie/chewie.dart';
import 'package:video_browse/widgets/custom_back_button.dart';
import 'package:video_browse/widgets/video_box/horizontal_box/horizontal_video_box.dart';
import 'package:video_browse/widgets/video_play/comment_box.dart';
import 'package:video_browse/widgets/video_play/comment_section.dart';
import 'package:video_browse/widgets/video_play/description.dart';
import 'package:video_player/video_player.dart';

class VideoPlayScreen extends StatefulWidget {
  final dynamic fun;
  final VideoInfo video;
  const VideoPlayScreen({
    Key? key,
    required this.video,
    this.fun,
  }) : super(key: key);

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  dynamic videoPlayerController;
  dynamic chewieController;
  dynamic playerWidget;
  double _height = 120.0;
  bool isComments = true;
  String comment = "";
  bool flag = false;
  TextEditingController controller = TextEditingController();

  Widget placeHolder = Image.asset(
    "assets/loading.gif",
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
    await widget.video.updateView(FetchUser().uid);
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

  List<HorizontalBox> getReccommends() {
    List<VideoInfo> videos = FetchVideos().getVideos();
    List<HorizontalBox> recVideos = <HorizontalBox>[];
    for (VideoInfo video in videos) {
      if (widget.video.getCategory() == video.getCategory() &&
          widget.video.getID() != video.getID()) {
        recVideos.add(
          HorizontalBox(
            info: video,
            fun: widget.fun,
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
        child: Stack(
          children: [
            Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.black,
                    width: double.infinity,
                    child: placeHolder,
                  ),
                ),
                Description(
                  video: widget.video,
                  fun: widget.fun,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: kColorBoxBorder,
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(3.3 * AppScale.heightMultiplier),
                        topRight:
                            Radius.circular(3.3 * AppScale.heightMultiplier),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 2.8 * AppScale.heightMultiplier,
                            bottom: 1.1 * AppScale.heightMultiplier,
                          ),
                          child: CommentSection(
                            fun: updateSection,
                            activeTitle: "Comments",
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            fit: StackFit.passthrough,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            children: [
                              widget.video.getCommentToggle() || !isComments
                                  ? ListView(
                                      children: isComments
                                          ? getComments()
                                          : getReccommends(),
                                    )
                                  : Column(
                                      children: [
                                        Image.asset(
                                          "assets/icons/comments_off.png",
                                          width:
                                              60.0 * AppScale.widthMultiplier,
                                          color: kColorPrimary,
                                        ),
                                        SizedBox(
                                          height:
                                              2.2 * AppScale.heightMultiplier,
                                        ),
                                        Text(
                                          disabledComments,
                                          style: TextStyle(
                                            color: kColorVideoText,
                                            fontSize:
                                                1.7 * AppScale.textMultiplier,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                              flag &&
                                      isComments &&
                                      widget.video.getCommentToggle()
                                  ? Positioned(
                                      bottom: 0.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height:
                                                7.8 * AppScale.heightMultiplier,
                                            width:
                                                73.0 * AppScale.widthMultiplier,
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 4.9 *
                                                  AppScale.widthMultiplier,
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
                                                      hintText:
                                                          "Leave a comment",
                                                      filled: true,
                                                      fillColor: kColorInactive,
                                                      counterStyle:
                                                          const TextStyle(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius: BorderRadius
                                                            .circular(1.1 *
                                                                AppScale
                                                                    .heightMultiplier),
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
                              isComments && widget.video.getCommentToggle()
                                  ? Positioned(
                                      bottom: 0.55 * AppScale.heightMultiplier,
                                      right: 3.65 * AppScale.widthMultiplier,
                                      child: GestureDetector(
                                        child: CircleAvatar(
                                          radius:
                                              3.3 * AppScale.heightMultiplier,
                                          backgroundColor: kColorActive,
                                          child: Image.asset(
                                            flag
                                                ? "assets/icons/check.png"
                                                : "assets/icons/write.png",
                                            width:
                                                6.1 * AppScale.widthMultiplier,
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
                                            Comment tempComment = Comment(
                                                FetchUser().currentUser,
                                                comment);
                                            widget.video
                                                .addComment(tempComment);
                                            comment = "";
                                            if (widget.fun != null) {
                                              widget.fun();
                                            }
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
            const CustomBackButton(),
          ],
        ),
      ),
    );
  }
}
