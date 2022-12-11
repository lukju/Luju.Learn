import '../models/cart.dart';
import '../models/cart_item.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/product.dart';

part 'cart_controller.g.dart';

@riverpod
class CurrentCart extends _$CurrentCart {
  @override
  Cart build() {
    return const Cart(items: {});
  }

  CartItem? getCartItemByProductId(String productId) {
    return state.items[productId];
  }

  void increaseQuantity(Product product, int deltaQuantity) {
    CartItem? cartItem = getCartItemByProductId(product.id);
    final newQuantity = (cartItem == null ? 0 : cartItem.quantity) + deltaQuantity;
    final newItems = <String, CartItem>{};
    state.items.forEach((key, value) {
      newItems[key] = value;
    });
    newItems[product.id] = CartItem(productId: product.id, quantity: newQuantity);
    state = Cart(items: newItems);
  }

  void reduceQuantity(Product product, int deltaQuantity) {
    CartItem? cartItem = getCartItemByProductId(product.id);
    if (cartItem != null) {
      final newItems = <String, CartItem>{};
      state.items.forEach((key, value) {
        newItems[key] = value;
      });
      cartItem = cartItem.copyWith(quantity: cartItem.quantity - deltaQuantity);
      newItems[product.id] = cartItem;
      if (cartItem.quantity <= 0) {
        newItems.remove(product.id);
      }
      state = Cart(items: newItems);
    }
  }
}
