import 'package:flutter/material.dart';

class PickImageCard extends StatelessWidget {
  final String image;
  final String text;
  final void Function() function;

  const PickImageCard(
      {super.key,
      required this.image,
      required this.text,
      required this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  image,
                  height: 60,
                  width: 60,
                ),
                Text(text),
              ],
            ),
          )),
    );
  }
}
