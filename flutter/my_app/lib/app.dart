import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/controllers/category_controller.dart';
import 'package:my_app/models/category.dart';
import 'package:my_app/widgets/products_list_widget.dart';

import 'models/product.dart';
import 'widgets/product_widget.dart';

class App extends ConsumerWidget {
  const App({super.key});

  _updateCategory(WidgetRef ref) {
    final currentCategoryNofifier = ref.read(currentCategoryProvider.notifier);
    currentCategoryNofifier.update("123");
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Layouts Tutorial"),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        "This is the bold title text",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: const Text("a subtitle description text"),
                      )
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () => _updateCategory(ref),
                        child: const Icon(
                          Icons.settings,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const ProductListWidget()
        ],
      ),
    );
  }
}
