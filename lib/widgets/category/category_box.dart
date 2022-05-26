import 'package:flutter/material.dart';
import 'package:video_browse/models/category.dart';
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
        width: category.getCategory().length * 22,
        margin: const EdgeInsets.only(
          right: 2.5,
          left: 2.5,
        ),
        decoration: BoxDecoration(
          color: isActive ? kColorActive : kColorPrimary,
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: Center(
          child: Text(
            category.getCategory(),
            style: TextStyle(
              color: isActive ? kColorPrimary : kColorInactive,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
