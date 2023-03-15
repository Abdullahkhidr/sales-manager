import 'package:manager/core/theme_app/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';

class ButtonWidget extends StatelessWidget {
  final Function() onTap;
  final String title;
  final bool secondaryButton;
  final double? elevation;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  const ButtonWidget(
      {super.key,
      required this.onTap,
      required this.title,
      this.secondaryButton = false,
      this.padding,
      this.margin,
      this.elevation,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin ?? const EdgeInsets.all(10),
      // width: double.infinity,
      child: FilledButton(
        onPressed: onTap,
        // onHover: (value) => ,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                secondaryButton ? const Color(0xfffce7e9) : null),
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4000)))),
        child: child ??
            Text(title,
                style: Fonts.t3(
                    fontWeight: FontWeight.w700,
                    color: !secondaryButton
                        ? colorScheme.onPrimary
                        : colorScheme.primary)),
      ),
    );
  }
}
