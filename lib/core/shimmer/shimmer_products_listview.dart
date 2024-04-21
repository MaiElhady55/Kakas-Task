import 'package:flutter/material.dart';
import 'package:kakas_task/core/shimmer/shimmer_container_effect.dart';
import 'package:kakas_task/core/utils/size_config.dart';

class ShimmerProductsListView extends StatelessWidget {
  const ShimmerProductsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = SizeConfig.height(context);
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ShimmerContainerEffect(
            height: h * 0.14, //108
            width: SizeConfig.width(context),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 24,
          );
        },
        itemCount: 4,
      ),
    );
  }
}
