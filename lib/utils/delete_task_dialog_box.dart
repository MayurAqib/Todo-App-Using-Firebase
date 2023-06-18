import 'package:flutter/material.dart';

import '../colors/colors.dart';

class DeleteDialogBox extends StatelessWidget {
  const DeleteDialogBox({super.key, required this.onDelete});
  final void Function()? onDelete;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text(
        'Are you sure?',
        style: TextStyle(color: textColor),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: textColor),
            )),
        TextButton(
            onPressed: onDelete,
            child: const Text(
              'Delete',
              style: TextStyle(color: textColor),
            )),
      ],
    );
  }
}
