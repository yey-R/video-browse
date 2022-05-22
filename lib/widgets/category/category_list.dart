import 'package:flutter/material.dart';
import 'package:video_browse/models/category.dart';
import 'package:video_browse/widgets/category/category_box.dart';

class CategoryList extends StatefulWidget {
  final List<Category> categoryList;
  final Function fun;
  final Category activeCategory;
  const CategoryList({
    Key? key,
    required this.categoryList,
    required this.fun,
    required this.activeCategory,
  }) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    super.initState();
    createCategories();
  }

  List<CategoryBox> createCategories() {
    List<CategoryBox> categories = <CategoryBox>[];
    for (Category category in widget.categoryList) {
      CategoryBox box = CategoryBox(
        category: category,
        fun: widget.fun,
        isActive: widget.activeCategory == category,
      );
      categories.add(box);
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    createCategories();
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: createCategories(),
      ),
    );
  }
}
