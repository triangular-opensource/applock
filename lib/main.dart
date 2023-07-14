import 'package:applock/presentation/first_page.dart';
import 'package:applock/presentation/Splashpage.dart';
import 'package:applock/utils/string_values.dart';
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
          title: AppValues.appName,
          initialRoute: Pagevalues.firstpage,
          routes: {
            Splashpage.routeNamed: (BuildContext context) => const Splashpage(),
            Firstpage.routeNamed: (BuildContext context) => const Firstpage(),
          },
          debugShowCheckedModeBanner: false);
    });
  }
}
