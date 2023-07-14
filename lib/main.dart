import 'package:applock/presentation/Splashpage.dart';
import 'package:applock/utils/StringValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(builder: (BuildContext context, Widget? child) {
      return MaterialApp(
          title: StringValues.appName,
          initialRoute: StringValues.splashPage,
          routes: {
            Splashpage.routeNamed: (BuildContext context) => const Splashpage()
          },
          debugShowCheckedModeBanner: false);
    });
  }
}