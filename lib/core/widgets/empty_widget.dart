import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/core/widgets/space_widget.dart';

class EmptyWidget extends StatelessWidget {
  final String msg;
  final String nameLottieFile;
  const EmptyWidget(
      {super.key, required this.msg, required this.nameLottieFile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Space(isH: true, count: 20),
        const SizedBox(width: double.maxFinite),
        Lottie.asset('assets/lottie/$nameLottieFile.json',
            reverse: true, width: Sizes.widthScreen / 1.7),
        const Space(isH: true, count: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(msg,
              textAlign: TextAlign.center,
              style: Fonts.t3(color: colorScheme.secondary.withAlpha(140))),
        ),
      ],
    );
  }
}
