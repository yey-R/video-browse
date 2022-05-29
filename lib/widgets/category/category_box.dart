import 'package:flutter/material.dart';
import 'package:video_browse/models/category.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';

class CategoryBox extends StatelessWidget {
  final bool isActive;
  final Category category;
  final Function fun;
  const CategoryBox({
    Key? key,
    required this.category,
    required this.fun,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => fun(category),
      child: Container(
        width: category.getCategory().length * 21,
        margin: EdgeInsets.symmetric(
          horizontal: 0.6 * AppScale.widthMultiplier,
        ),
        decoration: BoxDecoration(
          color: isActive ? kColorActive : kColorPrimary,
          borderRadius: BorderRadius.all(
            Radius.circular(3.3 * AppScale.heightMultiplier),
          ),
        ),
        child: Center(
          child: Text(
            category.getCategory(),
            style: TextStyle(
              color: isActive ? kColorPrimary : kColorInactive,
              fontSize: 1.7 * AppScale.textMultiplier,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
