import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:flutter/material.dart';

class LineWidget extends StatelessWidget {
  final double? width;
  final double? thickness;
  final Color? color;

  const LineWidget({super.key, this.width, this.thickness, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: Sizes.size(thickness ?? 0.2),
      decoration:
          BoxDecoration(color: color ?? colorScheme.secondary.withAlpha(100)),
    );
  }
}
