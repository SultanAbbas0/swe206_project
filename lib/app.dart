import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe206_project/constants.dart';
import 'package:swe206_project/views/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 811),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          // localizationsDelegates: context.localizationDelegates,
          // supportedLocales: context.supportedLocales,
          // locale: Locale(context.locale.languageCode),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(scaffoldBackgroundColor: scaffoldBackgroundColor),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
