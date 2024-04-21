import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kakas_task/core/functions/custom_appbar.dart';
import 'package:kakas_task/core/routes/routes_path.dart';
import 'package:kakas_task/core/shimmer/shimmer_products_listview.dart';
import 'package:kakas_task/core/utils/app_colors.dart';
import 'package:kakas_task/core/utils/app_images.dart';
import 'package:kakas_task/features/product/presentation/view_models/product_providers/product_provider.dart';
import 'package:kakas_task/features/product/presentation/views/widgets/custom_search_bar.dart';
import 'package:kakas_task/features/product/presentation/views/widgets/product_list_view_item.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductProvider>(context, listen: false).getAllProducts(null);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      appBar: customAppBar(
          title: 'Products',
          color: const Color.fromRGBO(249, 249, 249, 1),
          isIcon: false,
          context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          children: [
            CustomSearchBar(),
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
