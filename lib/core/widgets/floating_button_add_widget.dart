import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/core/widgets/space_widget.dart';

class FloatingButtonAddWidget extends StatelessWidget {
  final Function() onTap;
  final String title;
  const FloatingButtonAddWidget(
      {super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onTap,
      label: Row(
        children: [
          Text(title,
              style: Fonts.t4(
                  color: colorScheme.onPrimary, fontWeight: FontWeight.w600)),
          const Space(count: 2),
          const Icon(Icons.add)
        ],
      ),
    );
  }
}
