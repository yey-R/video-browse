import 'package:flutter/material.dart';
import 'package:video_browse/models/category.dart';
import 'package:video_browse/services/fetch_categories.dart';
import 'package:video_browse/services/fetch_videos.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';
import 'package:video_browse/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:video_browse/widgets/category/category_list.dart';
import 'package:video_browse/widgets/video_box/vertical_box/vertical_box_list.dart';

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
  dynamic _activeCategory;
  dynamic _isRefreshing;

  @override
  void initState() {
    super.initState();
    _videos = FetchVideos().getVideos();
    _categories = FetchCategories().getCategories();
    _activeCategory = _categories[0];
    refresh();
  }

  void refresh() async {
    setState(() {
      _isRefreshing = true;
    });
    FetchVideos().reset();
    await FetchVideos().setVideos();
    setState(() {
      _videos = FetchVideos().getVideos();
      _isRefreshing = false;
    });
  }

  void setFilter(Category activeCategory) {
    setState(
      () {
        _activeCategory = activeCategory;
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
          margin: EdgeInsets.only(
            left: 2.5 * AppScale.widthMultiplier,
            right: 2.5 * AppScale.widthMultiplier,
            top: 0.65 * AppScale.heightMultiplier,
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
                    width: 12.0 * AppScale.widthMultiplier,
                    color: kColorActive,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 2.4 * AppScale.widthMultiplier,
                      top: 0.65 * AppScale.heightMultiplier,
                    ),
                    child: Image.asset(
                      "assets/icons/icon_app_name.png",
                      width: 24.3 * AppScale.widthMultiplier,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.1 * AppScale.heightMultiplier,
              ),
              CategoryList(
                categoryList: _categories,
                fun: setFilter,
                activeCategory: _activeCategory,
              ),
              _isRefreshing
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: kColorOwnerText,
                        ),
                      ),
                    )
                  : VerticalBoxList(
                      videos: _videos,
                      category: _activeCategory,
                      fun: refresh,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
