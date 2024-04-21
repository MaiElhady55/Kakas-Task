import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kakas_task/core/routes/routes_path.dart';
import 'package:kakas_task/core/utils/app_colors.dart';
import 'package:kakas_task/core/utils/size_config.dart';
import 'package:kakas_task/core/utils/styles.dart';

class CustomSearchBar extends StatelessWidget {
  final Color iconsColor = Colors.white;
  final TextEditingController searchController = TextEditingController();

  CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: SizeConfig.width(context),
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white, //AppColors.kBorderColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search...',
              hintStyle: Styles.textStyle14.copyWith(),
              contentPadding:
                  const EdgeInsets.only(left: 16, top: 8, bottom: 10),
              suffixIcon: Container(
                width: 32,
                height: 32,
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).go(RoutesPath.kSearchProductView,
                          extra: searchController.text);
                    },
                    icon: Icon(
                      Icons.search,
                      color: iconsColor,
                      size: 20,
                    )),
              ),
            ),
            onFieldSubmitted: (value) {
              GoRouter.of(context)
                  .go(RoutesPath.kSearchProductView, extra: value);
            },
          ),
        ),
      ),
    );
  }
}
