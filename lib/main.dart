import 'package:applock/presentation/app_permission_data.dart';
import 'package:applock/presentation/custom/ask_permission_bottom_sheet.dart';
import 'package:applock/presentation/first_page.dart';
import 'package:applock/presentation/splash_page.dart';
import 'package:applock/utils/global_function.dart';
import 'package:applock/utils/string_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
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
            AppPermissionData.routeNamed: (BuildContext context) => const AppPermissionData(),
          },
          debugShowCheckedModeBanner: false);
    });
  }
}
