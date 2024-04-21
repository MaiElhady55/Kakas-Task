import 'package:flutter/material.dart';
import 'package:kakas_task/core/utils/styles.dart';

class CustomLines extends StatelessWidget {
  final String title;

  const CustomLines({super.key, required this.title});

  Widget buildContainer() {
    return Container(
      height: 2,
      width: 125,
      decoration: BoxDecoration(
          color: const Color(0xffF4F5F7),
          borderRadius: BorderRadius.circular(0.5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildContainer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'or Sign $title with',
            style: Styles.textStyle14,
          ),
        ),
        buildContainer()
      ],
    );
  }
}
