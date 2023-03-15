import 'package:manager/core/theme_app/theme_app.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  const IconWidget({super.key, this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(9),
        margin: const EdgeInsets.all(9),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: colorScheme.secondary.withAlpha(15), shape: BoxShape.circle),
        child: Icon(icon, color: colorScheme.secondary),
      ),
    );
  }
}
