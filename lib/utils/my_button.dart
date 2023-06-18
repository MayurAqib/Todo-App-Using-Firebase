import 'package:flutter/material.dart';
import 'package:to_do_app_using_rest_api/colors/colors.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.buttonText, required this.onTap});
  final String buttonText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: textColor),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
                color: darkbackground,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
        ),
      ),
    );
  }
}
