import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';

class TabWidget extends StatelessWidget {
  final String title;
  const TabWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Sizes.paddingScreen.subtract(const EdgeInsets.all(10)),
      child: Text(title, style: Fonts.t3()),
    );
  }
}
