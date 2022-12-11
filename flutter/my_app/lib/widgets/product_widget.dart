import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_item.dart';
import '../models/product.dart';
import '../controllers/cart_controller.dart';

class ProductWidget extends ConsumerWidget {
  const ProductWidget(
      {super.key, required this.product, required this.cartItem});

  final Product product;
  final CartItem? cartItem;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref
          .read(currentCartProvider.notifier)
          .increaseQuantity(product, 1),
      onDoubleTap: () =>
          ref.read(currentCartProvider.notifier).reduceQuantity(product, 1),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              width: double.infinity,
              padding: const EdgeInsets.all(3),
              child: Text(
                  product.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
            )),
          if (cartItem != null)
            Align(
              alignment: Alignment.center,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final badgeWidth = 0.2 * constraints.maxHeight;
                  return Container(
                    width: badgeWidth,
                    height: badgeWidth,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.75),
                      borderRadius: BorderRadius.all(
                        Radius.circular(badgeWidth / 2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${cartItem?.quantity}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: badgeWidth / 2),
                      ),
                    ),
                  );
                },
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 5000,
              color: Colors.white.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          "Preis: CHF ${product.formattedPrice}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
