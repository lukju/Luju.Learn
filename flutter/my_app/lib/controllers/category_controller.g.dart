// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String $CurrentCategoryHash() => r'f9fc5ec2e5ee0849ee5d0c3f6b598b11a087690b';

/// See also [CurrentCategory].
final currentCategoryProvider =
    AutoDisposeNotifierProvider<CurrentCategory, Category?>(
  CurrentCategory.new,
  name: r'currentCategoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $CurrentCategoryHash,
);
typedef CurrentCategoryRef = AutoDisposeNotifierProviderRef<Category?>;

abstract class _$CurrentCategory extends AutoDisposeNotifier<Category?> {
  @override
  Category? build();
}

String $ProductListHash() => r'0e86670363eadd4f0cb86ae44fd8181df2f9ab6e';

/// See also [ProductList].
final productListProvider =
    AutoDisposeNotifierProvider<ProductList, List<Product>>(
  ProductList.new,
  name: r'productListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : $ProductListHash,
);
typedef ProductListRef = AutoDisposeNotifierProviderRef<List<Product>>;

abstract class _$ProductList extends AutoDisposeNotifier<List<Product>> {
  @override
  List<Product> build();
}
