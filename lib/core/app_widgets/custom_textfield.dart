import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakas_task/core/utils/app_colors.dart';
import 'package:kakas_task/core/utils/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType type;
  final String? Function(String? val)? validator;
  final bool? obscureText;
  final Widget? suffix;
  final IconData? prefix;
  final IconData? suffixIcon;
  final TextInputAction textInputAction;
  final VoidCallback? suffixFun;
  final double height;
  final FocusNode? focusNode;
  final bool icon;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.hintText,
      required this.type,
      this.prefix,
      this.icon = false,
      this.inputFormatters,
      this.suffix,
      this.validator,
      this.obscureText = false,
      this.suffixIcon,
      this.suffixFun,
      required this.textInputAction,
      this.focusNode,
      this.height = 44});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(
            decoration: TextDecoration.none, decorationThickness: 0),
        validator: validator,
        textInputAction: textInputAction,
        focusNode: focusNode,
        controller: controller,
        inputFormatters: inputFormatters,
        autocorrect: false,
        keyboardType: type,
        obscureText: obscureText!,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColors.kBorderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColors.kBorderColor)),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.only(top: 16, bottom: 20, left: 16),
          hintText: hintText,
          hintStyle: Styles.textStyle18
              .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          isDense: true,
          prefixIcon: Icon(
            prefix,
            color: AppColors.kPrimartTextColor,
            size: 23,
          ),
          suffixIcon: icon
              ? suffix
              : IconButton(
                  icon: Icon(
                    suffixIcon,
                    color: AppColors.kPrimartTextColor,
                    size: 20,
                  ),
                  onPressed: suffixFun),
        ));
  }
}
