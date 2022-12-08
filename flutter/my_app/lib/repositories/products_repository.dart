import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/category.dart';
import '../models/product.dart';

part 'products_repository.g.dart';

@riverpod
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepository();
}

class ProductRepository {
  List<Product> getProductsByCategory(Category? category) {
    if (category == null) return [];
    return const [
      Product(
          id: "1",
          title: 'Wienerli mit Brot',
          price: 4.5,
          imageUrl:
              'https://thelandscapephotoguy.com/wp-content/uploads/2019/01/landscape%20new%20zealand%20S-shape.jpg'),
      Product(
          id: "2",
          title: 'Heisser Schinken mit Kartoffelsalat',
          price: 12,
          imageUrl:
              'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6.jpg'),
      Product(
          id: "3",
          title: 'Heisser Schinken mit Brot',
          price: 10,
          imageUrl: 'https://www.nevada-map.org/nevada-road.jpg'),
      Product(
          id: "4",
          title: '2 Weisswürste mit Brot',
          price: 9,
          imageUrl:
              'https://content.r9cdn.net/rimg/dimg/54/bf/f200cbe4-reg-146-1685d758f3b.jpg?width=440&height=220&xhint=1472&yhint=1083&crop=true'),
              Product(
          id: "5",
          title: 'Wienerli mit Brot',
          price: 4.5,
          imageUrl:
              'https://thelandscapephotoguy.com/wp-content/uploads/2019/01/landscape%20new%20zealand%20S-shape.jpg'),
      Product(
          id: "6",
          title: 'Heisser Schinken mit Kartoffelsalat',
          price: 12,
          imageUrl:
              'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6.jpg'),
      Product(
          id: "7",
          title: 'Heisser Schinken mit Brot',
          price: 10,
          imageUrl: 'https://www.nevada-map.org/nevada-road.jpg'),
      Product(
          id: "8",
          title: '2 Weisswürste mit Brot',
          price: 9,
          imageUrl:
              'https://content.r9cdn.net/rimg/dimg/54/bf/f200cbe4-reg-146-1685d758f3b.jpg?width=440&height=220&xhint=1472&yhint=1083&crop=true')
    ];
  }
}
