import 'package:flutter/material.dart';
import 'package:kakas_task/core/utils/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final void Function() onTap;
  final Color color;
  final IconData icon;

  const CustomIconButton(
      {super.key,
      required this.onTap,
      required this.color,
      required this.icon});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              border: Border.all(color: AppColors.kBorderColor),
              color: Colors.white),
          child: Center(
              child: Icon(
            icon,
            size: 20,
            color: color,
          ))),
    );
  }
}
