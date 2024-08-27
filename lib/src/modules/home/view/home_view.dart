import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_moving_background/enums/animation_types.dart";
import "package:flutter_moving_background/flutter_moving_background.dart";
import "package:get/get.dart";
import "package:icons_plus/icons_plus.dart";
import "package:tic_tac_toe/src/core/common/colors.dart";

import "../controllers/home_controller.dart";
import "../widgets/custom_drawer.dart";

///
class HomeView extends GetView<HomeController> {
  ///
  const HomeView({super.key});

  @override
  String? get tag => homeControllerTag;

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: CustomDrawer(controller: controller),
        key: controller.scaffoldKey,
        extendBody: true,
        appBar: AppBar(
          //backgroundColor: MColors.orange,
          forceMaterialTransparency: true,
          centerTitle: false,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                controller.openDrawer();
              },
              icon: const Icon(
                BoxIcons.bx_menu_alt_right,
                //color: Colors.white,
                size: 27,
              ),
            )
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "welcome".trParams(
                  <String, String>{
                    "username": controller.currentUser?.displayName != null
                        ? controller.currentUser!.displayName!
                        : "",
                  },
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  //color: Colors.white,
                ),
              ),
              Text(
                controller.greetUser.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  // color: Colors.white,
                ),
              ),
            ],
          ),
          leading: Container(
            margin: const EdgeInsets.only(left: 18),
            height: 40,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: controller.currentUser?.photoURL != null
                  ? NetworkImage(
                      controller.currentUser!.photoURL!,
                    )
                  : null,
            ),
          ),
        ),
        body: MovingBackground(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          animationType: AnimationType.translation,
          duration: const Duration(seconds: 15),
          circles: const [
            MovingCircle(
              color: MColors.primary,
              radius: 200,
            ),
            MovingCircle(color: MColors.errorContainer, radius: 200),
            MovingCircle(color: Colors.blue, radius: 200),
            MovingCircle(color: Colors.greenAccent, radius: 200),
            MovingCircle(color: MColors.orange, radius: 200),
            MovingCircle(color: MColors.secondary, radius: 200),
            MovingCircle(color: MColors.tertiary, radius: 200),
            MovingCircle(color: MColors.tertiaryContainer, radius: 200),
          ],
          child: Stack(
            children: [
              /*Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Material(
                  elevation: 20,
                  shadowColor: MColors.orange,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: MColors.orange,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),*/
              Positioned(
                left: 50,
                right: 50,
                bottom: 100,
                child: Column(
                  children: [
                    Text(
                      "play_mode".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextButton.icon(
                      onPressed: controller.payAloneGame,
                      icon: const Icon(
                        AntDesign.user_outline,
                        color: Colors.white,
                      ),
                      label: Text(
                        "player_1".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ButtonStyle(
                        minimumSize: MaterialStatePropertyAll<Size>(
                          Size(Get.width, 55),
                        ),
                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        backgroundColor:
                            const MaterialStatePropertyAll<Color>(Colors.black),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextButton.icon(
                      icon: const Icon(
                        AntDesign.user_switch_outline,
                        color: Colors.white,
                      ),
                      onPressed: controller.payWithFriends,
                      label: Text(
                        "player_2".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ButtonStyle(
                        minimumSize: MaterialStatePropertyAll<Size>(
                          Size(Get.width, 55),
                        ),
                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        backgroundColor:
                            const MaterialStatePropertyAll<Color>(Colors.black),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextButton.icon(
                      icon: const Icon(
                        AntDesign.usergroup_add_outline,
                        color: Colors.white,
                      ),
                      onPressed: controller.payWithFriendsOnline,
                      label: Text(
                        "player_3".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ButtonStyle(
                        minimumSize: MaterialStatePropertyAll<Size>(
                          Size(Get.width, 55),
                        ),
                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        backgroundColor:
                            const MaterialStatePropertyAll<Color>(Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
