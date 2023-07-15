import 'package:applock/controller/MethodChangeController.dart';
import 'package:applock/utils/fonts.dart';
import 'package:applock/utils/global_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AskPermissionBootomSheet extends StatelessWidget {
  const AskPermissionBootomSheet({Key? key}) : super(key: key);

  Widget permissionWidget(context, name, bool permission) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 6,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        // height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 6,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$name",
                style: MyFont().subtitle(
                  color: Colors.white,
                  fontweight: FontWeight.w400,
                  fontsize: 14,
                ),
              ),
              const Spacer(),
              // if (permission)
              Icon(
                Icons.check_circle,
                color: !permission
                    ? Colors.grey[700]
                    : Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: GetBuilder<MethodChannelController>(builder: (state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Text(
                        "AppLock needs system permissions to work with.",
                        textAlign: TextAlign.center,
                        style: MyFont().subtitle(
                          color: Colors.white,
                          fontweight: FontWeight.w400,
                          fontsize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (!state.isOverlayPermissionGiven)
                            GestureDetector(
                              onTap: () {
                                state.askOverlayPermission();
                              },
                              child: permissionWidget(
                                context,
                                "System overlay",
                                state.isOverlayPermissionGiven,
                              ),
                            ),
                          if (!state.isUsageStatPermissionGiven)
                            GestureDetector(
                              onTap: () {
                                state.askUsageStatsPermission();
                              },
                              child: permissionWidget(
                                context,
                                "Usage accesss",
                                state.isUsageStatPermissionGiven,
                              ),
                            ),
                          if (!state.isNotificationPermissionGiven)
                            GestureDetector(
                              onTap: () {
                                state.askNotificationPermission();
                              },
                              child: permissionWidget(
                                context,
                                "Push notification",
                                state.isNotificationPermissionGiven,
                              ),
                            ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        if (await state.checkOverlayPermission() &&
                            await state.checkUsageStatePermission() &&
                            await state.checkNotificationPermission()) {
                          Navigator.pop(context);
                        } else {
                          showToast(
                              msg: "Required permissions not given !");
                        }
                      },
                      child: Text(
                        "Confirm",
                        style: MyFont().subtitle(
                          color: Colors.black,
                          fontweight: FontWeight.w400,
                          fontsize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}