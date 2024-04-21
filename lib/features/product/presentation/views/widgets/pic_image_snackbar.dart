import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> imagePickerSnackBar(
    BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text('No Image Captured'),
  ));
}
