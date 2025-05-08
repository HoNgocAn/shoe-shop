import 'dart:async';
import 'package:shoe_shop_flutter/data/model/category_model.dart';
import 'package:shoe_shop_flutter/data/repository/category_repository.dart';

class CategoryViewModel {
  final CategoryRepository repository; // <-- dùng interface thôi

  final StreamController<List<Category>> categoryStream = StreamController<List<Category>>();

  CategoryViewModel({required this.repository});

  Future<void> loadCategories() async {
    try {
      List<Category> categories = await repository.getCategoryList();

      if (categories.isNotEmpty) {
        categoryStream.add(categories);
      } else {
        categoryStream.add([]); // optional, nhưng vẫn tốt
      }
    } catch (error) {
      categoryStream.addError(error);
    }
  }

  void dispose() {
    categoryStream.close();
  }
}