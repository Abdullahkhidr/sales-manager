import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/button_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/login_signup/presentation/pages/phone_auth/verification_phone_page.dart';

class PhoneAuthPage extends StatelessWidget {
  const PhoneAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
        child: CustomScrollView(
          slivers: [
            AppBarWidget('Signin With Phone', center: false),
            SliverList(
                delegate: SliverChildListDelegate([
              const Space(isH: true, count: 14),
              IntlPhoneField(
                // initialCountryCode: 'IN',
                style: Fonts.t3(),
                decoration: InputDecoration(
                    hintText: 'Phone Number',
                    contentPadding: const EdgeInsets.all(16),
                    counter: const SizedBox(),
                    hintStyle:
                        Fonts.t3(color: colorScheme.secondary.withAlpha(100))),
                flagsButtonPadding: const EdgeInsets.all(0),
                onSubmitted: (p0) {},
                dropdownIcon: Icon(Icons.arrow_drop_down_rounded,
                    color: colorScheme.secondary),
                dropdownTextStyle: Fonts.t3(),
                pickerDialogStyle: PickerDialogStyle(
                    padding: Sizes.paddingScreen,
                    width: Sizes.widthScreen,
                    listTileDivider: const SizedBox(),
                    backgroundColor: colorScheme.background,
                    countryNameStyle: Fonts.t5(),
                    countryCodeStyle: Fonts.t5()),
                onChanged: (phone) {},
              ),
              ButtonWidget(
                  onTap: () => Nav.to(const VerificationPhonePage()),
                  title: 'Send Code')
            ]))
          ],
        ),
      ),
    );
  }
}
