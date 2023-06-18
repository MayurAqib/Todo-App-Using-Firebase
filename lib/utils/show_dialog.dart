import 'package:flutter/material.dart';

class ShowDialogs extends StatelessWidget {
  const ShowDialogs({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text(message));
  }
}
