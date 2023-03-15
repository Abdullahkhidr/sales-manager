import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';

import '../theme_app/theme_app.dart';

class FieldWidget extends StatelessWidget {
  final IconData? startIcon;
  final Widget? endIcon;
  final void Function()? actionEndIcon;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final bool? readOnly;
  final Function(String)? onChange;
  final Function()? onTap;
  const FieldWidget(
      {super.key,
      this.startIcon,
      this.endIcon,
      required this.hintText,
      this.obscureText = false,
      this.keyboardType,
      this.actionEndIcon,
      this.controller,
      this.maxLines,
      this.textInputAction,
      this.onTap,
      this.readOnly,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: Sizes.borderRadius, boxShadow: [
          BoxShadow(color: colorScheme.primary, blurRadius: 5, spreadRadius: -3)
        ]),
        child: TextField(
          obscureText: obscureText,
          readOnly: readOnly ?? false,
          onTap: onTap,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChange,
          textInputAction: textInputAction ?? TextInputAction.next,
          decoration: InputDecoration(
              hintText: hintText,
              fillColor: colorScheme.background,
              filled: true,
              hintStyle: Fonts.t3(
                  color:
                      Theme.of(context).colorScheme.secondary.withAlpha(130)),
              prefixIcon: startIcon == null ? null : Icon(startIcon),
              suffixIcon: endIcon),
          style: Fonts.t3(),
        ),
      ),
    );
  }
}
