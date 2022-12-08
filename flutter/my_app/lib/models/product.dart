import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

@freezed
class Product with _$Product {
  const Product._();
  const factory Product({required String id, required String imageUrl, required String title, required double price,}) = _Product;


  String get formattedPrice {
    final valueLeft = price.toInt();
    int valueAfterDot = ((price - valueLeft) * 100).toInt();
    String valueRight = valueAfterDot.toString();
    if (valueAfterDot == 0) {
      valueRight = "—";
    } else if (valueAfterDot < 10) {
      valueRight = '${valueRight}0';
    }
    return "$valueLeft.$valueRight";
  }
}
