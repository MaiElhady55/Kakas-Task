import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kakas_task/core/routes/routes_path.dart';

customAppBar(
    {required String title,
    Color? color,
    bool isIcon = true,
    required BuildContext context}) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    elevation: 0,
    backgroundColor: color,
    leading: isIcon
        ? InkWell(
            onTap: () {
              GoRouter.of(context).go(RoutesPath.kProductsView);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          )
        : null,
  );
}
