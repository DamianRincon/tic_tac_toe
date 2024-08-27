import "dart:ui";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:icons_plus/icons_plus.dart";
import "package:tic_tac_toe/src/core/common/constants_key.dart";
import "package:tic_tac_toe/src/core/utils/app_info.dart";

import "../../../core/routes/routes.dart";
import "../controllers/home_controller.dart";
import "item_drawer.dart";

///
class CustomDrawer extends StatelessWidget {
  ///
  const CustomDrawer({
    required this.controller,
    super.key,
  });

  ///
  final HomeController controller;

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        width: Get.width,
        child: Stack(
          children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: controller.closeDrawer,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: SizedBox(
                  width: Get.width,
                  height: Get.height,
                  // child: child,
                ),
              ),
            ),
            Container(
              height: Get.height,
              width: Get.width - 100,
              margin: EdgeInsets.only(
                left: 10,
                top: GetPlatform.isIOS ? 50 : 25,
                bottom: GetPlatform.isIOS ? 35 : 25,
              ),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: Get.width,
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 5),
                          Image.asset(
                            "assets/images/ic_launcher.png",
                            width: 50,
                            height: 50,
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                APP_NAME,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),
                    ItemDrawer(
                      title: "rules".tr,
                      icon: const Icon(AntDesign.book_outline),
                      isSelected: false,
                      onPress: () => Get.toNamed(Routes.rules),
                    ),
                    ItemDrawer(
                      title: "about_of".tr,
                      isSelected: false,
                      icon: const Icon(BoxIcons.bx_info_circle),
                      onPress: () => Get.toNamed(Routes.aboutOf),
                    ),
                    ItemDrawer(
                      title: "settings".tr,
                      isSelected: false,
                      icon: const Icon(BoxIcons.bx_cog),
                      onPress: () => Get.toNamed(Routes.settings),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 100,
              child: InkWell(
                onTap: () {
                  controller.launcherURL(AppInfo.terms ?? "");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      "terms".tr,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
