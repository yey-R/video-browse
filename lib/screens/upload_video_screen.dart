import 'package:flutter/material.dart';
import 'package:video_browse/models/category.dart';
import 'package:video_browse/models/user.dart';
import 'package:video_browse/models/video_info.dart';
import 'package:video_browse/services/fetch_categories.dart';
import 'package:video_browse/services/upload_video.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:video_browse/widgets/category/category_list.dart';
import 'package:video_browse/widgets/input_box.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:video_browse/widgets/login/login_button.dart';

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
  bool _commentToggle = false;
  bool _emptyInput = false;
  dynamic _categories;
  int _index = 0;

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
      bottomNavigationBar: const CustomBottomNavigationBar(),
      backgroundColor: kColorPrimary,
      body: SafeArea(
        child: Column(
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
            GestureDetector(
              onTap: () {
                uploader.pickVideo();
              },
              child: const LoginButton(
                buttonText: "Select Video",
              ),
            ),
            GestureDetector(
              child: Image.asset(
                "assets/icons/upload.png",
                color: kColorActive,
                width: 100.0,
              ),
              onTap: () {
                if (_name.isEmpty ||
                    _description.isEmpty ||
                    uploader.isFilePicked()) {
                  setState(() {
                    _emptyInput = true;
                  });
                  return;
                }
                uploader.uploadVideo(
                  VideoInfo(
                    name: _name,
                    user: User("Emre"),
                    description: _description,
                    duration: 0,
                    category: _category.getCategory(),
                    commentToggle: _commentToggle,
                    likes: null,
                    thumbnailURL: null,
                    uploadDate: null,
                    videoURL: null,
                    view: null,
                    viewLastDay: null,
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
      ),
    );
  }
}
