import 'dart:developer';
import 'dart:typed_data';
import 'package:applock/controller/MethodChangeController.dart';
import 'package:applock/models/application_data.dart';
import 'package:applock/models/application_data_model.dart';
import 'package:applock/utils/global_function.dart';
import 'package:applock/utils/string_values.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppsController extends GetxController implements GetxService {
  SharedPreferences prefs;
  AppsController({required this.prefs});

  String? dummyPasscode;
  int? selectQuestion;
  TextEditingController typeAnswer = TextEditingController();
  TextEditingController checkAnswer = TextEditingController();
  TextEditingController searchApkText = TextEditingController();
  List<Application> unLockList = [];
  List<ApplicationDataModel> searchedApps = [];
  List<ApplicationDataModel> lockList = [];
  List<String> selectLockList = [];
  bool addToAppsLoading = false;

  List<String> excludedApps = ["com.android.settings"];

  int appSearchUpdate = 1;
  int addRemoveToUnlockUpdate = 2;
  int addRemoveToUnlockUpdateSearch = 3;

  changeQuestionIndex(index) {
    selectQuestion = index;
    update();
  }

  resetAskQuetionsPage() {
    selectQuestion = null;
    typeAnswer.clear();
    checkAnswer.clear();
  }

  savePasscode(counter) {
    prefs.setString(AppValues.setPassCode, counter);
    Get.find<MethodChannelController>().setPassword();
    log("${prefs.getString(AppValues.setPassCode)}", name: "save passcode");
  }

  getPasscode() {
    return prefs.getString(AppValues.setPassCode) ?? "";
  }

  removePasscode() {
    return prefs.remove(AppValues.setPassCode);
  }

  setSplash() {
    prefs.setBool("Splash", true);
    return prefs.getBool("Splash");
  }

  getSplash() async {
    final prefs = await SharedPreferences.getInstance();
    if ((prefs.getBool("Splash")) != null) {
      return true;
    } else {
      return false;
    }
  }

  excludeApps() {
    for (var e in excludedApps) {
      unLockList.removeWhere((element) => element.packageName == e);
    }
  }

  getAppsData() async {
    unLockList = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );
    excludeApps();
    update();
  }

  addRemoveFromLockedAppsFromSearch(ApplicationData app) {
    addToAppsLoading = true;
    update();
    try {
      if (selectLockList.contains(app.appName)) {
        selectLockList.remove(app.appName);
        lockList.removeWhere(
            (element) => element.application!.appName == app.appName);
      } else {
        if (lockList.length < 16) {
          selectLockList.add(app.appName);
          lockList.add(
            ApplicationDataModel(
              isLocked: true,
              application: ApplicationData(
                apkFilePath: app.apkFilePath,
                appName: app.appName,
                category: app.category,
                dataDir: app.dataDir,
                enabled: app.enabled,
                icon: getAppIcon(app.appName),
                installTimeMillis: app.installTimeMillis,
                packageName: app.packageName,
                systemApp: app.systemApp,
                updateTimeMillis: app.updateTimeMillis,
                versionCode: app.versionCode,
                versionName: app.versionName,
              ),
            ),
          );
        } else {
          showToast(msg: "You can add only 16 apps in locked list");
        }
      }
    } catch (e) {
      log("-------$e", name: "addRemoveFromLockedAppsFromSearch");
    }
    addToAppsLoading = false;
    update();
  }

  addToLockedApps(Application app, context) async {
    addToAppsLoading = true;
    update([addRemoveToUnlockUpdate]);
    try {
      if (selectLockList.contains(app.appName)) {
        selectLockList.remove(app.appName);
        lockList.removeWhere((em) => em.application!.appName == app.appName);
        log("REMOVE: $selectLockList");
      } else {
        if (lockList.length < 16) {
          selectLockList.add(app.appName);
          lockList.add(
            ApplicationDataModel(
              isLocked: true,
              application: ApplicationData(
                apkFilePath: app.apkFilePath,
                appName: app.appName,
                category: "${app.category}",
                dataDir: "${app.dataDir}",
                enabled: app.enabled,
                icon: (app as ApplicationWithIcon).icon,
                installTimeMillis: "${app.installTimeMillis}",
                packageName: app.packageName,
                systemApp: app.systemApp,
                updateTimeMillis: '${app.updateTimeMillis}',
                versionCode: '${app.versionCode}',
                versionName: '${app.versionName}',
              ),
            ),
          );
          log("ADD: $selectLockList", name: "addToLockedApps");
          Get.find<MethodChannelController>().addToLockedAppsMethod();
        } else {
          showToast(msg: "You can add only 16 apps in locked list");
        }
      }
    } catch (e) {
      log("-------$e", name: "addToLockedApps");
    }
    prefs.setString(
        AppValues.lockedApps, applicationDataModelToJson(lockList));
    addToAppsLoading = false;
    update([addRemoveToUnlockUpdate]);
  }

  getLockedApps() {
    try {
      lockList = applicationDataModelFromJson(
          prefs.getString(AppValues.lockedApps) ?? '');
      selectLockList.clear();
      log('${lockList.length}', name: "STORED LIST");
      for (var e in lockList) {
        selectLockList.add(e.application!.appName);
      }
      log('${lockList.length}-$selectLockList', name: "Locked Apps");
    } catch (e) {
      log("-------$e", name: "getLockedApps");
    }

    update();
  }
  Uint8List getAppIcon(String appName) {
    return (unLockList[unLockList.indexWhere((element) {
      return appName == element.appName;
    })] as ApplicationWithIcon)
        .icon;
  }

  appSearch() {
    searchedApps.clear();
    if (searchApkText.text.length > 2) {
      for (var e in unLockList) {
        if (e.appName
            .toUpperCase()
            .contains(searchApkText.text.toUpperCase().trim())) {
          searchedApps.add(
            ApplicationDataModel(
              isLocked: null,
              application: ApplicationData(
                apkFilePath: e.apkFilePath,
                appName: e.appName,
                category: "${e.category}",
                dataDir: "${e.dataDir}",
                enabled: e.enabled,
                icon: (e as ApplicationWithIcon).icon,
                installTimeMillis: "${e.installTimeMillis}",
                packageName: e.packageName,
                systemApp: e.systemApp,
                updateTimeMillis: '${e.updateTimeMillis}',
                versionCode: '${e.versionCode}',
                versionName: '${e.versionName}',
              ),
            ),
          );
        }
      }
      update([appSearchUpdate]);
    }
  }
  
}
