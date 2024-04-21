import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kakas_task/core/functions/custom_appbar.dart';
import 'package:kakas_task/core/routes/routes_path.dart';
import 'package:kakas_task/core/shimmer/shimmer_products_listview.dart';
import 'package:kakas_task/core/utils/app_colors.dart';
import 'package:kakas_task/core/utils/app_images.dart';
import 'package:kakas_task/features/product/presentation/view_models/product_providers/product_provider.dart';
import 'package:kakas_task/features/product/presentation/views/widgets/product_list_view_item.dart';
import 'package:provider/provider.dart';

class SearchProductView extends StatefulWidget {
  final String searchText;

  const SearchProductView({super.key, required this.searchText});

  @override
  State<SearchProductView> createState() => _SearchProductViewState();
}

class _SearchProductViewState extends State<SearchProductView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductProvider>(context, listen: false)
          .getAllProducts(widget.searchText);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      appBar: customAppBar(
          title: 'Search',
          color: const Color.fromRGBO(249, 249, 249, 1),
          context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Consumer<ProductProvider>(
              builder: (BuildContext context, productProvider, Widget? child) {
                if (productProvider.isLoading) {
                  return const ShimmerProductsListView();
                } else if (productProvider.productList.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Image.asset(
                        AppImages.noProduct,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: productProvider.productList.length,
                    itemBuilder: (context, index) {
                      return ProductsListViewItem(
                        productModel: productProvider.productList[index],
                      );
                    },
                  ));
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.kPrimaryColor,
        onPressed: () {
          GoRouter.of(context).go(RoutesPath.kAddProductView);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
