import 'package:flutter/material.dart';
import 'package:to_do_app_using_rest_api/colors/colors.dart';

class DrawerRow extends StatelessWidget {
  const DrawerRow({super.key, required this.icon, required this.information});
  final IconData icon;
  final String information;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Icon(
            icon,
            color: textColor.withOpacity(0.4),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            information,
            style: TextStyle(
                color: textColor.withOpacity(0.8), fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
