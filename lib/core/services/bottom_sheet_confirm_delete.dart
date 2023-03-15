import 'package:flutter/material.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/core/widgets/button_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/main.dart';

bottomSheetConfirmDelete(Function() onConfirm) {
  showModalBottomSheet(
    context: navigatorKey.currentContext!,
    backgroundColor: colorScheme.background,
    builder: (context) {
      return Padding(
        padding: Sizes.paddingScreen,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Delete', style: Fonts.t2()),
            const Space(isH: true, count: 3),
            Text('Do You Want to Delete?', style: Fonts.t4()),
            const Space(isH: true, count: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ButtonWidget(
                      onTap: () {
                        Nav.back;
                      },
                      title: 'Cancel'),
                ),
                Expanded(
                  child: ButtonWidget(
                      onTap: onConfirm,
                      title: 'Confirm',
                      secondaryButton: true),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
