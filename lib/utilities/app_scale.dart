import 'package:flutter/widgets.dart';

class AppScale {
  static final AppScale _appScale = AppScale._internal();
  static dynamic _mediaQueryData;
  static dynamic _screenWidth;
  static dynamic _screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static dynamic textMultiplier;
  static dynamic imageSizeMultiplier;
  static dynamic heightMultiplier;
  static dynamic widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  factory AppScale() {
    return _appScale;
  }

  AppScale._internal();

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    if (_mediaQueryData.orientation == Orientation.portrait) {
      _screenWidth = _mediaQueryData.size.width;
      _screenHeight = _mediaQueryData.size.height;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = _mediaQueryData.size.height;
      _screenHeight = _mediaQueryData.size.width;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
  }
}
