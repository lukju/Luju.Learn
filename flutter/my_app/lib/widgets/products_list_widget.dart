import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/cart_controller.dart';
import '../controllers/category_controller.dart';

import 'product_widget.dart';

class ProductListWidget extends ConsumerWidget {
  const ProductListWidget({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);
    final cart = ref.watch(cartControllerProvider);
    final widgetWidth = MediaQuery.of(context).size.width;
    final columnCount = max((widgetWidth ~/ 250), 1);

    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.2,
          crossAxisCount: columnCount,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final cartItem = cart.items[product.id];
          return ProductWidget(product: product, cartItem: cartItem);
        });
  }
}
