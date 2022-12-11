import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../repositories/products_repository.dart';

part 'products_controller.g.dart';

@riverpod
class CurrentCategory extends _$CurrentCategory {
  @override
  Category? build() {
    return null;
  }

  void update(Category category) {
    state = category;
  }
}

@riverpod
class CategoryFilteredProductList extends _$CategoryFilteredProductList {
  @override
  Future<List<Product>> build() async {
    final productsRepo = ref.watch(productsRepositoryProvider);
    final currentCategory = ref.watch(currentCategoryProvider);
    List<Product> products = currentCategory == null ? []: await productsRepo.loadProductsByCategory(currentCategory);
    return products;
  }
}

@riverpod
class UnfilteredProductList extends _$CategoryFilteredProductList {
  @override
  Future<List<Product>> build(){
    final productsRepo = ref.watch(productsRepositoryProvider);
    return productsRepo.loadAllProducts();
  }
}

@riverpod
class CategoryList extends _$CategoryList {
  @override
  Future<List<Category>> build(){
    final productsRepo = ref.watch(productsRepositoryProvider);
    return productsRepo.loadAllCategories();
  }
}
