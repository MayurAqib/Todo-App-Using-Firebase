import 'package:flutter/material.dart';

import '../colors/colors.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield(
      {super.key,
      required this.controller,
      this.hintText,
      this.obscureText = false,
      this.icon});
  final TextEditingController controller;
  final bool? obscureText;
  final String? hintText;
  final IconButton? icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        style: const TextStyle(color: darkbackground),
        controller: controller,
        cursorColor: textColor,
        obscureText: obscureText!,
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: icon,
            hintStyle: const TextStyle(color: darkbackground),
            filled: true,
            fillColor: textColor,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
