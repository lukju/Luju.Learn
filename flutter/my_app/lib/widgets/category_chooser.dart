import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/controllers/products_controller.dart';

import '../controllers/cart_controller.dart';
import '../models/category.dart';
import '../models/product.dart';

class CategoryChooserWidget extends ConsumerWidget {
  const CategoryChooserWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Category>> categoriesAsync =
        ref.watch(categoryListProvider);
    return SizedBox(
      child: categoriesAsync.when(
        data: (categories) =>
            _LoadedCategoryChooserWidget(categories: categories),
        error: (error, stack) => const _ErroredCategoryChooserWidget(),
        loading: () => const _LoadingCategoryChooserWidget(),
      ),
    );
  }
}

class _LoadedCategoryChooserWidget extends ConsumerWidget {
  const _LoadedCategoryChooserWidget({
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> categoryWidgets = [];
    for (var category in categories) {
      var widget = Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            ref.read(currentCategoryProvider.notifier).update(category);
          },
          child: Text(category.title),
        ),
      );
      categoryWidgets.add(widget);
    }

    return Row(
      children: categoryWidgets,
    );
  }
}

class _LoadingCategoryChooserWidget extends ConsumerWidget {
  const _LoadingCategoryChooserWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ErroredCategoryChooserWidget extends ConsumerWidget {
  const _ErroredCategoryChooserWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Oops, something unexpected happened'),
    );
  }
}
