import 'package:flutter/material.dart';
import 'package:video_browse/models/category.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/widgets/category/category_box.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categoryList;
  final Function fun;
  final Category activeCategory;
  const CategoryList({
    Key? key,
    required this.categoryList,
    required this.fun,
    required this.activeCategory,
  }) : super(key: key);

  List<CategoryBox> createCategories() {
    List<CategoryBox> categories = <CategoryBox>[];
    for (Category category in categoryList) {
      CategoryBox box = CategoryBox(
        category: category,
        fun: fun,
        isActive: activeCategory == category,
      );
      categories.add(box);
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6.0 * AppScale.heightMultiplier,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: createCategories(),
      ),
    );
  }
}
