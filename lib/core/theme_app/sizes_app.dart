import 'package:flutter/material.dart';
import 'package:manager/main.dart';

class Sizes {
  static EdgeInsets paddingScreen = const EdgeInsets.all(20);
  static BorderRadius borderRadius = BorderRadius.circular(8);
  static double get heightScreen =>
      MediaQuery.of(navigatorKey.currentContext!).size.height;
  static double get widthScreen =>
      MediaQuery.of(navigatorKey.currentContext!).size.width;

  static double size(double size) {
    double valMobile = 0.00232;
    double valTablet = 0.0016;
    bool isMobile = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .size
            .shortestSide <
        600;
    double val = isMobile ? valMobile : valTablet;
    double resSize = (heightScreen * val) * (widthScreen * val) * size;
    return resSize;
  }

  static double h1() => size(14);
  static double h2() => size(12);
  static double h3() => size(9.4);
  static double h4() => size(8.7);
  static double h5() => size(7.3);
  static double h6() => size(6);
}
