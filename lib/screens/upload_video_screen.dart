import 'package:flutter/material.dart';
import 'package:video_browse/models/category.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/screens/video_play_screen.dart';
import 'package:video_browse/services/fetch_categories.dart';
import 'package:video_browse/services/fetch_user.dart';
import 'package:video_browse/services/upload_video.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/action_button.dart';
import 'package:video_browse/widgets/category/category_list.dart';
import 'package:video_browse/widgets/custom_back_button.dart';
import 'package:video_browse/widgets/input_box.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({Key? key}) : super(key: key);

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  final UploadVideo uploader = UploadVideo();
  String _name = "";
  String _description = "";
  dynamic _category;
  bool _commentToggle = true;
  bool _emptyInput = false;
  dynamic _categories;
  int _index = 0;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    _categories = FetchCategories().getCategories();
    _category = _categories[0];
  }

  void update(value, flag) {
    setState(
      () {
        if (flag) {
          _name = value;
        } else {
          _description = value;
        }
      },
    );
  }

  void setCategory(Category activeCategory) {
    setState(() {
      _category = activeCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isUploading ? Colors.black : kColorPrimary,
      body: SafeArea(
        child: isUploading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/loading.gif",
                    ),
                    const Text(
                      "Upload in Progress",
                      style: TextStyle(
                        color: kColorOwnerText,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              )
            : Stack(
                children: [
                  const CustomBackButton(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40.0,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: const Text(
                          "UPLOAD YOU OWN CONTENT!",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: kColorInactive,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      InputBox(
                        fun: update,
                        hint: "Title",
                      ),
                      InputBox(
                        fun: update,
                        hint: "Description",
                      ),
                      CategoryList(
                        categoryList: _categories.sublist(1),
                        fun: setCategory,
                        activeCategory: _category,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ToggleSwitch(
                        activeBgColor: const [kColorActive],
                        activeFgColor: kColorPrimary,
                        inactiveBgColor: kColorInactive,
                        inactiveFgColor: kColorPrimary,
                        minWidth: 200.0,
                        minHeight: 50.0,
                        initialLabelIndex: _index,
                        totalSwitches: 2,
                        labels: const ['Comments On', 'Comments Off'],
                        changeOnTap: true,
                        onToggle: (index) {
                          setState(() {
                            _commentToggle = index == 0 ? true : false;
                            _index = index!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ActionButton(
                        buttonText: "Select Video",
                        width: 150.0,
                        routerPage: null,
                        replace: false,
                        fun: uploader.pickVideo,
                      ),
                      GestureDetector(
                        child: Image.asset(
                          "assets/icons/upload.png",
                          color: kColorActive,
                          width: 100.0,
                        ),
                        onTap: () async {
                          if (_name.isEmpty ||
                              _description.isEmpty ||
                              uploader.isFilePicked()) {
                            setState(() {
                              _emptyInput = true;
                            });
                            return;
                          }
                          setState(() {
                            isUploading = true;
                          });
                          VideoInfo newVideo = VideoInfo(
                            name: _name,
                            user: FetchUser().currentUser,
                            description: _description,
                            duration: 0,
                            category: _category.getCategory(),
                            commentToggle: _commentToggle,
                          );
                          await uploader.uploadVideo(newVideo);
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  VideoPlayScreen(
                                video: newVideo,
                              ),
                            ),
                          );
                        },
                      ),
                      _emptyInput
                          ? const SizedBox(
                              width: double.infinity,
                              height: 20.0,
                              child: Text(
                                "Input fields cannot be empty!",
                                style: TextStyle(
                                  color: kColorInactive,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : const SizedBox(
                              height: 20.0,
                            ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
