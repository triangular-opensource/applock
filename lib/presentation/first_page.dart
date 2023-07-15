import 'package:applock/utils/global_function.dart';
import 'package:applock/utils/string_values.dart';
import 'package:flutter/material.dart';

class Firstpage extends StatefulWidget {
  static String routeNamed = Pagevalues.firstpage;
  const Firstpage({Key? key}) : super(key: key);

  @override
  State<Firstpage> createState() => _FirstPageState();
}

class _FirstPageState extends State<Firstpage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, Pagevalues.appPermissionDataPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            IconStringsvalues.appIcon,
            height: setHeight(120),
            width: setWidth(120),
          ),
          const SizedBox(
            height: (128),
          ),
          Text(
            AppValues.appNameUpperCase,
          ),
        ],
      ),
    );
  }
}
