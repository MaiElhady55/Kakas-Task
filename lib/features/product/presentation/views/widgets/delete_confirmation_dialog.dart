import 'package:flutter/material.dart';
import 'package:kakas_task/core/utils/styles.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final Function onConfirm;

  const DeleteConfirmationDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Confirm Deletion',
          style: Styles.textStyle18,
        ),
      ),
      content: Text(
        'Are you sure you want to delete this product?',
        style: Styles.textStyle14.copyWith(fontSize: 16),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: Styles.textStyle18,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.blue),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(
            'OK',
            style: Styles.textStyle18,
          ),
        ),
      ],
    );
  }
}
