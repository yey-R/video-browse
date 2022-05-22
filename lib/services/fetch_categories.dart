import 'package:firebase_database/firebase_database.dart';
import 'package:video_browse/models/category.dart';

class FetchCategories {
  static final FetchCategories _fetchCategories = FetchCategories._internal();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final List<Category> _categoryList = <Category>[];
  dynamic _value;

  factory FetchCategories() {
    return _fetchCategories;
  }

  FetchCategories._internal();

  Future<void> fetchCategories() async {
    final snapshot = await _dbRef.child('categories').get();
    if (snapshot.exists) {
      _value = snapshot.value;
    }
  }

  Future<void> setCategories() async {
    _categoryList.clear();
    if (_value == null) await fetchCategories();

    for (var name in _value) {
      _categoryList.add(
        Category(
          name,
        ),
      );
    }
  }

  List<Category> getCategories() {
    return _categoryList;
  }
}
