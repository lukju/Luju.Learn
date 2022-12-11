import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/controllers/products_controller.dart';

import '../controllers/cart_controller.dart';
import '../models/product.dart';

class CartWidget extends ConsumerWidget {
  const CartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Product>> productsAsync =
        ref.watch(unfilteredProductListProvider);
    return SizedBox(
      width: 0.3 * MediaQuery.of(context).size.width,
      child: productsAsync.when(
        data: (products) => _LoadedCartWidget(products: products),
        error: (error, stack) => const _ErroredCartWidget(),
        loading: () => const _LoadingCartWidget(),
      ),
    );
  }
}

class _LoadedCartWidget extends ConsumerWidget {
  const _LoadedCartWidget({
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(currentCartProvider);

    List<Widget> cartItems = [];
    double totalPrice = 0;
    for (var product in products) {
      var cartItem = cart.items[product.id];
      if (cartItem != null) {
        double price = cartItem.quantity * product.price;
        totalPrice = totalPrice + price;
        var widget = ListTile(
          leading: Text("${cartItem.quantity}"),
          trailing: Text(
            "$price",
            textAlign: TextAlign.end,
          ),
          title: Text(product.title),
        );
        cartItems.add(widget);
      }
    }

    return Column(
      children: [
         Expanded(
           child: ListView(
            children: cartItems,
        ),
         ),
        Text("Total Price: $totalPrice")
      ],
    );
  }
}

class _LoadingCartWidget extends ConsumerWidget {
  const _LoadingCartWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ErroredCartWidget extends ConsumerWidget {
  const _ErroredCartWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Oops, something unexpected happened'),
    );
  }
}
