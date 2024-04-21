import 'package:flutter/material.dart';
import 'package:kakas_task/core/utils/styles.dart';

void customSnackBar(context, String text, {Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: Styles.textStyle18,
    ),
    backgroundColor: color,
  ));
}
