import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';

class SelectOptionWidget extends StatelessWidget {
  final String textSelectedOption;
  final String typeOptions;
  final List<PopupMenuEntry<dynamic>> itemBuilder;
  const SelectOptionWidget(
      {super.key,
      required this.textSelectedOption,
      required this.typeOptions,
      required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: [
          Expanded(
            child: Text(typeOptions,
                textAlign: TextAlign.start, style: Fonts.t3()),
          ),
          Expanded(
            flex: 3,
            child: PopupMenuButton(
              constraints: BoxConstraints(
                  maxWidth: Sizes.widthScreen - Sizes.widthScreen / 10),
              surfaceTintColor: colorScheme.background,
              color: colorScheme.background,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: colorScheme.secondary.withAlpha(10),
                      border:
                          Border.all(color: colorScheme.primary, width: 0.2),
                      borderRadius: Sizes.borderRadius),
                  child: Text(textSelectedOption,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      style: Fonts.t3())),
              itemBuilder: (context) => itemBuilder,
            ),
          )
        ]));
  }
}
