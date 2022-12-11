// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_controller.dart';

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

String $CurrentCategoryHash() => r'c25d45befdf043bf92a4e138ce3d2a9736551bf9';

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

String $CategoryFilteredProductListHash() =>
    r'10ffaa0f2c05a544f6b2b9ebabe0b1bf98596fa7';

/// See also [CategoryFilteredProductList].
final categoryFilteredProductListProvider = AutoDisposeAsyncNotifierProvider<
    CategoryFilteredProductList, List<Product>>(
  CategoryFilteredProductList.new,
  name: r'categoryFilteredProductListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $CategoryFilteredProductListHash,
);
typedef CategoryFilteredProductListRef
    = AutoDisposeAsyncNotifierProviderRef<List<Product>>;

abstract class _$CategoryFilteredProductList
    extends AutoDisposeAsyncNotifier<List<Product>> {
  @override
  FutureOr<List<Product>> build();
}

String $UnfilteredProductListHash() =>
    r'702f144fa816eb6434e459658d7f1feb82798bcf';

/// See also [UnfilteredProductList].
final unfilteredProductListProvider =
    AutoDisposeAsyncNotifierProvider<UnfilteredProductList, List<Product>>(
  UnfilteredProductList.new,
  name: r'unfilteredProductListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $UnfilteredProductListHash,
);
typedef UnfilteredProductListRef
    = AutoDisposeAsyncNotifierProviderRef<List<Product>>;

abstract class _$UnfilteredProductList
    extends AutoDisposeAsyncNotifier<List<Product>> {
  @override
  FutureOr<List<Product>> build();
}

String $CategoryListHash() => r'884a9fb665295f8497855ed784067db6b1979266';

/// See also [CategoryList].
final categoryListProvider =
    AutoDisposeAsyncNotifierProvider<CategoryList, List<Category>>(
  CategoryList.new,
  name: r'categoryListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : $CategoryListHash,
);
typedef CategoryListRef = AutoDisposeAsyncNotifierProviderRef<List<Category>>;

abstract class _$CategoryList extends AutoDisposeAsyncNotifier<List<Category>> {
  @override
  FutureOr<List<Category>> build();
}
