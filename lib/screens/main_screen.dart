import 'package:flutter/material.dart';
import 'package:video_browse/models/category.dart';
import 'package:video_browse/services/fetch_categories.dart';
import 'package:video_browse/services/fetch_videos.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:video_browse/widgets/category/category_list.dart';
import 'package:video_browse/widgets/video_list/video_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  dynamic _videos;
  dynamic _categories;
  dynamic categoryList;
  dynamic videoList;

  @override
  void initState() {
    super.initState();
    _videos = FetchVideos().getVideos();
    _categories = FetchCategories().getCategories();
    setFilter(_categories[0]);
  }

  void setFilter(Category activeCategory) {
    setState(
      () {
        categoryList = CategoryList(
          categoryList: _categories,
          fun: setFilter,
          activeCategory: activeCategory,
        );
        videoList = VideoList(
          videos: _videos,
          category: activeCategory,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(
        isHome: true,
      ),
      backgroundColor: kColorPrimary,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 6.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/app.gif",
                    width: 50.0,
                    color: kColorActive,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, top: 6.0),
                    child: Image.asset(
                      "assets/icons/icon_app_name.png",
                      width: 100.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              categoryList,
              videoList,
            ],
          ),
        ),
      ),
    );
  }
}
