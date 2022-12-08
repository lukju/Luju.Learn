import 'cart_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart.freezed.dart';

@freezed
class Cart with _$Cart {
  const factory Cart({required Map<String, CartItem> items, }) = _Cart;
}
