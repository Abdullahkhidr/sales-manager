import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/main.dart';

class Fonts {
  static TextStyle t1({Color? color, FontWeight? fontWeight}) => TextStyle(
      fontSize: Sizes.h1(),
      color:
          color ?? Theme.of(navigatorKey.currentContext!).colorScheme.secondary,
      fontWeight: fontWeight ?? FontWeight.bold);
  static TextStyle t2({Color? color, FontWeight? fontWeight}) => TextStyle(
      fontSize: Sizes.h2(),
      color:
          color ?? Theme.of(navigatorKey.currentContext!).colorScheme.secondary,
      fontWeight: fontWeight ?? FontWeight.w700);
  static TextStyle t3({Color? color, FontWeight? fontWeight}) => TextStyle(
      fontSize: Sizes.h3(),
      color:
          color ?? Theme.of(navigatorKey.currentContext!).colorScheme.secondary,
      fontWeight: fontWeight ?? FontWeight.w600);
  static TextStyle t4({Color? color, FontWeight? fontWeight}) => TextStyle(
      fontSize: Sizes.h4(),
      color:
          color ?? Theme.of(navigatorKey.currentContext!).colorScheme.secondary,
      fontWeight: fontWeight ?? FontWeight.w500);
  static TextStyle t5({Color? color, FontWeight? fontWeight}) => TextStyle(
      fontSize: Sizes.h5(),
      color:
          color ?? Theme.of(navigatorKey.currentContext!).colorScheme.secondary,
      fontWeight: fontWeight ?? FontWeight.w400);
  static TextStyle t6({Color? color, FontWeight? fontWeight}) => TextStyle(
      fontSize: Sizes.h6(),
      color:
          color ?? Theme.of(navigatorKey.currentContext!).colorScheme.secondary,
      fontWeight: fontWeight ?? FontWeight.w400);
}
