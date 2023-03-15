import 'package:flutter/material.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/login_signup/presentation/pages/phone_auth/phone_auth_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await HiveServices.init;
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const ManagerApp()),
  );
}

class ManagerApp extends StatelessWidget {
  const ManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const PhoneAuthPage());
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
