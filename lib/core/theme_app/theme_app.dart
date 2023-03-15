import 'package:manager/main.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/colors_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';

ColorScheme colorScheme = Theme.of(navigatorKey.currentContext!).colorScheme;

final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: ColorsAppLight.bgColor,
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
    appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // titleTextStyle: Fonts.t1(),
        iconTheme: IconThemeData(color: ColorsAppLight.secondaryColor)),
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: ColorsAppLight.primaryColor,
        onPrimary: ColorsAppLight.lightColor,
        secondary: ColorsAppLight.secondaryColor,
        onSecondary: ColorsAppLight.primaryColor,
        error: ColorsAppLight.lightColor,
        onError: ColorsAppLight.primaryColor,
        background: ColorsAppLight.bgColor,
        onBackground: ColorsAppLight.primaryColor,
        surface: ColorsAppLight.primaryColor,
        onSurface: ColorsAppLight.lightColor),
    textTheme: const TextTheme(
        labelLarge: TextStyle(color: ColorsAppLight.lightColor)),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        fillColor: ColorsAppLight.secondaryColor.withAlpha(10),
        filled: true,
        hintStyle:
            TextStyle(color: ColorsAppLight.secondaryColor.withAlpha(100)),
        focusColor: ColorsAppLight.primaryColor.withAlpha(80),
        hoverColor: ColorsAppLight.primaryColor.withAlpha(80),
        focusedBorder: OutlineInputBorder(
            borderRadius: Sizes.borderRadius,
            borderSide:
                const BorderSide(width: 1, color: ColorsAppLight.primaryColor)),
        border: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: Sizes.borderRadius,
            borderSide: BorderSide.none),
        iconColor: ColorsAppLight.secondaryColor.withAlpha(110)),
    buttonTheme: const ButtonThemeData(
        buttonColor: ColorsAppLight.primaryColor,
        textTheme: ButtonTextTheme.primary));

final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Cairo',
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
    scaffoldBackgroundColor: ColorsAppDark.bgColor,
    appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // titleTextStyle: Fonts.t1(),
        iconTheme: IconThemeData(color: ColorsAppDark.secondaryColor)),
    textTheme:
        const TextTheme(labelLarge: TextStyle(color: ColorsAppDark.lightColor)),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        fillColor: ColorsAppDark.secondaryColor.withAlpha(10),
        focusColor: ColorsAppDark.primaryColor.withAlpha(100),
        hoverColor: ColorsAppLight.primaryColor.withAlpha(100),
        focusedBorder: OutlineInputBorder(
            borderRadius: Sizes.borderRadius,
            borderSide:
                const BorderSide(width: 1, color: ColorsAppDark.primaryColor)),
        border: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: Sizes.borderRadius,
            borderSide: BorderSide.none),
        // hintStyle: Fonts.t2(color: ColorsAppDark.secondaryColor.withAlpha(160)),
        iconColor: ColorsAppDark.secondaryColor.withAlpha(110)),
    buttonTheme: const ButtonThemeData(
        buttonColor: ColorsAppDark.primaryColor,
        textTheme: ButtonTextTheme.primary),
    colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: ColorsAppDark.primaryColor,
            onPrimary: ColorsAppDark.lightColor,
            secondary: ColorsAppDark.secondaryColor,
            onSecondary: ColorsAppDark.primaryColor,
            error: ColorsAppDark.lightColor,
            onError: ColorsAppDark.primaryColor,
            background: ColorsAppDark.bgColor,
            onBackground: ColorsAppDark.primaryColor,
            surface: ColorsAppDark.primaryColor,
            onSurface: ColorsAppDark.lightColor)
        .copyWith(background: ColorsAppDark.bgColor));
