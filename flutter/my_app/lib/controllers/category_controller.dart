import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../repositories/products_repository.dart';

part 'category_controller.g.dart';

@riverpod
class CurrentCategory extends _$CurrentCategory {
  @override
  Category? build() {
    return null;
  }

  void update(String categoryId) {
    if (state == null) {
      state = Category(id: categoryId, title: "Category $categoryId");
    } else {
      state = null;
    }
  }
}

@riverpod
class ProductList extends _$ProductList {
  @override
  List<Product> build() {
    final productsRepo = ref.watch(productRepositoryProvider);
    final currentCategory = ref.watch(currentCategoryProvider);
    final products = productsRepo.getProductsByCategory(currentCategory);
    return products;
  }
}

