import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/cart_controller.dart';
import '../controllers/products_controller.dart';

import '../models/product.dart';
import 'product_widget.dart';

class ProductListWidget extends ConsumerWidget {
  const ProductListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Product>> productsAsync =
        ref.watch(categoryFilteredProductListProvider);
    final currentCategory = ref.watch(currentCategoryProvider);

    if (currentCategory == null) {
      return Container();
    }
    return Expanded(
      child: productsAsync.when(
        data: (products) => _LoadedProductListWidget(products: products),
        error: (error, stack) => const _ErroredProductListWidget(),
        loading: () => const _LoadingProductListWidget(),
      ),
    );
  }
}

class _LoadedProductListWidget extends ConsumerWidget {
  const _LoadedProductListWidget({
    required this.products,
  });
  final List<Product> products;

  _calcColumnCount(BuildContext context) {
    int minimalColumnWidth = 250;
    final widgetWidth = MediaQuery.of(context)
        .size
        .width; // TODO: get widget width instead of screen width;
    int columnCount = max((widgetWidth ~/ minimalColumnWidth), 1);
    if (products.isNotEmpty &&
        (products.length * minimalColumnWidth) < widgetWidth) {
      minimalColumnWidth = widgetWidth ~/ products.length;
      columnCount = columnCount = max((widgetWidth ~/ minimalColumnWidth), 1);
    }
    return columnCount;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final RenderBox renderBox = context.findRenderObject() as RenderBox;
    //print(renderBox.size);
    final cart = ref.watch(currentCartProvider);

    List<ProductWidget> productWidgets = [];
    for (var product in products) {
      final cartItem = cart.items[product.id];
      productWidgets.add(ProductWidget(product: product, cartItem: cartItem));
    }

    return Align(
      alignment: Alignment.topCenter,
      child: GridView.count(
        shrinkWrap: true,
        primary: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        crossAxisCount: _calcColumnCount(context),
        childAspectRatio: 1.2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        children: productWidgets,
      ),
    );
  }
}

class _LoadingProductListWidget extends ConsumerWidget {
  const _LoadingProductListWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ErroredProductListWidget extends ConsumerWidget {
  const _ErroredProductListWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Oops, something unexpected happened'),
    );
  }
}
