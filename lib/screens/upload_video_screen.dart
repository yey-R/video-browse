import 'package:flutter/material.dart';
import 'package:video_browse/models/category.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/screens/video_play_screen.dart';
import 'package:video_browse/services/fetch_categories.dart';
import 'package:video_browse/services/fetch_user.dart';
import 'package:video_browse/services/upload_video.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/action_button.dart';
import 'package:video_browse/widgets/category/category_list.dart';
import 'package:video_browse/widgets/custom_back_button.dart';
import 'package:video_browse/widgets/input_box/input_box.dart';
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
  String _status = "Upload in Progress";
  bool _fileSelected = false;
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

  void setTitle(value) {
    _name = value;
  }

  void setDescription(value) {
    _description = value;
  }

  void setCategory(Category activeCategory) {
    setState(() {
      _category = activeCategory;
    });
  }

  void upload() async {
    if (_name.isEmpty || _description.isEmpty || uploader.isFilePicked()) {
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
      category: _category.getCategory(),
      commentToggle: _commentToggle,
    );
    await uploader.uploadVideo(newVideo, updateStatus);
    UploadVideo().reset();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => VideoPlayScreen(
          video: newVideo,
        ),
      ),
    );
  }

  void updateStatus(String status) {
    setState(() {
      _status = status;
    });
  }

  void selectFile() async {
    dynamic result = await uploader.pickVideo();
    setState(() {
      _fileSelected = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kColorPrimary,
      body: SafeArea(
        child: isUploading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: kColorActive,
                    ),
                    SizedBox(height: 3.0 * AppScale.heightMultiplier),
                    Text(
                      _status,
                      style: TextStyle(
                        color: kColorOwnerText,
                        fontSize: 2.2 * AppScale.textMultiplier,
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
                        height: 4.45 * AppScale.heightMultiplier,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: 3.65 * AppScale.widthMultiplier,
                        ),
                        child: Text(
                          uploadContent,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: kColorInactive,
                            fontSize: 2.8 * AppScale.textMultiplier,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      InputBox(
                        fun: setTitle,
                        hint: "Title",
                        maxLength: 30,
                      ),
                      InputBox(
                        fun: setDescription,
                        hint: "Description",
                        maxLength: 150,
                      ),
                      CategoryList(
                        categoryList: _categories.sublist(1),
                        fun: setCategory,
                        activeCategory: _category,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 1.1 * AppScale.heightMultiplier,
                        ),
                        child: ToggleSwitch(
                          activeBgColor: const [kColorActive],
                          activeFgColor: kColorPrimary,
                          inactiveBgColor: kColorInactive,
                          inactiveFgColor: kColorPrimary,
                          minWidth: 48.0 * AppScale.widthMultiplier,
                          minHeight: 5.6 * AppScale.heightMultiplier,
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
                      ),
                      ActionButton(
                        buttonText:
                            !_fileSelected ? "Select Video" : "Video Selected",
                        width: 36.5 * AppScale.widthMultiplier,
                        routerPage: null,
                        replace: false,
                        fun: selectFile,
                        color: _fileSelected ? kColorActive : kColorInactive,
                      ),
                      ActionButton(
                        buttonImage: Image.asset(
                          "assets/icons/upload.png",
                          color: kColorActive,
                          width: 24.0 * AppScale.widthMultiplier,
                        ),
                        width: 0,
                        routerPage: null,
                        replace: false,
                        fun: upload,
                      ),
                      _emptyInput
                          ? SizedBox(
                              width: double.infinity,
                              height: 2.2 * AppScale.heightMultiplier,
                              child: const Text(
                                emptyInput,
                                style: TextStyle(
                                  color: kColorInactive,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : SizedBox(
                              height: 2.2 * AppScale.heightMultiplier,
                            ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
