import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/main.dart';

void showMsg(String msg) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
      content: Text(msg, style: Fonts.t6(color: colorScheme.background)),
      backgroundColor: colorScheme.secondary));
}
