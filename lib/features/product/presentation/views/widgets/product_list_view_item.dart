//import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kakas_task/core/functions/custom_snackbar.dart';
import 'package:kakas_task/core/routes/routes_path.dart';
import 'package:kakas_task/core/utils/app_colors.dart';
import 'package:kakas_task/features/product/data/models/product_model.dart';
import 'package:kakas_task/features/product/presentation/view_models/product_providers/product_provider.dart';
import 'package:kakas_task/features/product/presentation/views/widgets/custom_icon_button.dart';
import 'package:kakas_task/features/product/presentation/views/widgets/delete_confirmation_dialog.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/size_config.dart';
import '../../../../../core/utils/styles.dart';

class ProductsListViewItem extends StatelessWidget {
  final ProductModel productModel;

  const ProductsListViewItem({super.key, required this.productModel});

  void deleteProduct(BuildContext context) async {
    await context
        .read<ProductProvider>()
        .deleteProduct(id: productModel.id ?? -1);
    if (context.read<ProductProvider>().isSuccess) {
      customSnackBar(context, 'Delete Product Successfully',
          color: Colors.green);
      // GoRouter.of(context).pushReplacement(RoutesPath.kProductsView);
    } else {
      customSnackBar(context, 'Delete Product Failed', color: Colors.red);
      GoRouter.of(context).pop();
    }
  }

  void showDeleteDialog(BuildContext context,
      {required void Function() onTap}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(onConfirm: onTap);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var h = SizeConfig.height(context);
    var w = SizeConfig.width(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: AppColors.kBorderColor)),
        height: h * 0.14, //108
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.kBorderColor)),
                  child: CachedNetworkImage(
                    imageUrl: productModel.image ?? '',
                    width: w * 0.28, //108
                    height: h * 0.14,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(productModel.title ?? '', style: Styles.textStyle18),
                      Text('\$${productModel.price}',
                          style: Styles.textStyle14
                              .copyWith(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.height(context) * 0.060, right: 10),
              child: Row(
                children: [
                  CustomIconButton(
                      onTap: () {
                        GoRouter.of(context).go(RoutesPath.kEditProductView,
                            extra: productModel);
                      },
                      color: Colors.blue,
                      icon: Icons.edit),
                  const SizedBox(
                    width: 10,
                  ),
                  Consumer<ProductProvider>(
                    builder: (BuildContext context, value, Widget? child) =>
                        CustomIconButton(
                            onTap: () async {
                              showDeleteDialog(
                                context,
                                onTap: () async {
                                  await value.deleteProduct(
                                      id: productModel.id ?? -1);
                                  if (value.isSuccess) {
                                    customSnackBar(
                                        context, 'Delete Product Successfully',
                                        color: Colors.green);
                                  } else {
                                    customSnackBar(
                                        context, 'Delete Product Failed',
                                        color: Colors.red);
                                  }
                                },
                              );
                            },
                            color: Colors.red,
                            icon: Icons.delete),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
