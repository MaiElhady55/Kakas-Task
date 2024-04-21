import 'package:flutter/material.dart';
import 'package:kakas_task/core/utils/app_colors.dart';

class SocialButton extends StatelessWidget {
  final void Function() fun;
  final String text;
  final String imageIcon;

  const SocialButton(
      {super.key,
      required this.fun,
      required this.text,
      required this.imageIcon});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 48, //SizeConfig.width(context)*,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.kBorderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Image.asset(
            imageIcon,
            fit: BoxFit.cover,
            width: 27,
            height: 27,
          ),
        ),
      ),
    );
  }
}
