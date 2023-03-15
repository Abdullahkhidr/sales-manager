import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/button_widget.dart';
import 'package:manager/features/login_signup/presentation/bloc/bloc/phone_auth_bloc.dart';
import 'package:manager/features/login_signup/presentation/widgets/pin_code_widget.dart';

class VerificationPhonePage extends StatelessWidget {
  const VerificationPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
        child: BlocProvider(
          create: (context) => PhoneAuthBloc(),
          child: CustomScrollView(
            slivers: [
              AppBarWidget('Verification Code', center: false),
              BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
                builder: (context, state) {
                  PhoneAuthBloc bloc = context.read<PhoneAuthBloc>();
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    PinCodeWidget(
                        controller: bloc.pinCodeController,
                        onCompleted: (v) {},
                        onChanged: (v) {}),
                    ButtonWidget(onTap: () {}, title: 'Verification Code')
                  ]));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
