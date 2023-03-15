import 'package:flutter/material.dart';
import 'package:manager/main.dart';

class Nav {
  static void to(Widget page) => Navigator.of(navigatorKey.currentContext!)
      .push(MaterialPageRoute(builder: (context) => page));

  static void get back => Navigator.pop(navigatorKey.currentContext!);
  static void toName(String page, [Object? arguments]) =>
      Navigator.of(navigatorKey.currentContext!)
          .pushNamed(page, arguments: arguments);
  static void replace(Widget page) => Navigator.of(navigatorKey.currentContext!)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
  static void replaceAll(Widget page) =>
      Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => page), (route) => false);
}
