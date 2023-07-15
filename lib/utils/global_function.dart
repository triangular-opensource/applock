import 'package:applock/controller/AppController.dart';
import 'package:applock/controller/HomeScreenController.dart';
import 'package:applock/controller/MethodChangeController.dart';
import 'package:applock/controller/PermissionController.dart';
import 'package:applock/presentation/custom/ask_permission_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

setHeight(height) => ScreenUtil().setHeight(height);
setWidth(width) => ScreenUtil().setWidth(width);


Future<void> initialize() async {
  final prefs = await SharedPreferences.getInstance();
  Get.lazyPut(() => prefs);
  Get.lazyPut(() => AppsController(prefs: Get.find()));
  Get.lazyPut(() => HomeScreenController(prefs: Get.find()));
  Get.lazyPut(() => MethodChannelController());
  Get.lazyPut(() => PermissionController());
}



askPermissionBottomSheet(context) {
  return showModalBottomSheet(
    barrierColor: Colors.black.withOpacity(0.8),
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return const AskPermissionBootomSheet();
    },
  );
}


showToast({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.black,
      fontSize: 16.0);
}