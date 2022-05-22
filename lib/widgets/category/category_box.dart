import 'package:flutter/material.dart';
import 'package:video_browse/models/category.dart';
import 'package:video_browse/utilities/constants.dart';

class CategoryBox extends StatefulWidget {
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
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => widget.fun(widget.category),
      child: Container(
        width: widget.category.getCategory().length * 22,
        margin: const EdgeInsets.only(
          right: 2.5,
          left: 2.5,
        ),
        decoration: BoxDecoration(
          color: widget.isActive ? kColorActive : kColorPrimary,
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: Center(
          child: Text(
            widget.category.getCategory(),
            style: TextStyle(
              color: widget.isActive ? kColorPrimary : kColorInactive,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
