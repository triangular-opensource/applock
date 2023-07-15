
import 'package:applock/controller/AppController.dart';
import 'package:applock/controller/MethodChangeController.dart';
import 'package:applock/controller/PermissionController.dart';
import 'package:applock/presentation/Splashpage.dart';
import 'package:applock/utils/global_function.dart';
import 'package:applock/utils/string_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionData extends StatefulWidget {
      static String routeNamed = Pagevalues.appPermissionDataPage;

  const AppPermissionData({Key? key}) : super(key: key);

  @override
  State<AppPermissionData> createState() => _AppPermissionDataState();
}

class _AppPermissionDataState extends State<AppPermissionData> {
 
  getPermissions() async {
    if (!(await Get.find<MethodChannelController>()
            .checkNotificationPermission()) ||
        !(await Get.find<MethodChannelController>().checkOverlayPermission()) ||
        !(await Get.find<MethodChannelController>()
            .checkUsageStatePermission())) {
      Get.find<MethodChannelController>().update();
      askPermissionBottomSheet(context);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Get.find<AppsController>().getAppsData();
      Get.find<AppsController>().getLockedApps();
      Get.find<PermissionController>().getPermission(Permission.ignoreBatteryOptimizations);
      getPermissions();
      Get.find<MethodChannelController>().addToLockedAppsMethod();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Splashpage();
  }
}
