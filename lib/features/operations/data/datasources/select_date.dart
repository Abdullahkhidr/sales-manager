import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/main.dart';

Future<DateTime> pickDate(DateTime initDate) async {
  DateTime? date = await showDatePicker(
    context: navigatorKey.currentContext!,
    initialDate: initDate,
    firstDate: DateTime(1800),
    lastDate: DateTime.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
          data: ThemeData.light().copyWith(
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.light(primary: colorScheme.primary)
                .copyWith(secondary: Colors.pinkAccent),
          ),
          child: child!);
    },
  );
  return date ?? initDate;
}
