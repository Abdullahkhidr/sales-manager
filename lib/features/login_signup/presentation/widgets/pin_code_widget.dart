import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onCompleted;
  final Function(String) onChanged;
  const PinCodeWidget(
      {super.key,
      required this.controller,
      required this.onCompleted,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: true,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: Sizes.borderRadius,
        fieldHeight: Sizes.size(20),
        fieldWidth: Sizes.size(20),
        activeFillColor: Colors.white,
        borderWidth: 0,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      // errorAnimationController: errorController,
      controller: controller,
      onCompleted: onCompleted,
      onChanged: onChanged, appContext: context,
    );
  }
}
