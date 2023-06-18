import 'package:flutter/material.dart';

import '../colors/colors.dart';

class DialogBox extends StatelessWidget {
  const DialogBox(
      {super.key,
      required this.onCancel,
      required this.onSave,
      required this.controller});
  final void Function() onCancel;
  final void Function() onSave;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text(
        'Add New Task',
        style: TextStyle(color: textColor),
      ),
      content: TextField(
        controller: controller,
        cursorColor: darkbackground,
        decoration: const InputDecoration(
            hintText: 'Add New Task',
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            filled: true,
            fillColor: white,
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
      actions: [
        TextButton(
            onPressed: onCancel,
            child: const Text(
              'Cancel',
              style: TextStyle(color: textColor),
            )),
        TextButton(
            onPressed: onSave,
            child: const Text(
              'Save',
              style: TextStyle(color: textColor),
            )),
      ],
    );
  }
}
