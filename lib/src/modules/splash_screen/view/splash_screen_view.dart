import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:lottie/lottie.dart";
import "package:tic_tac_toe/src/core/utils/app_info.dart";

import "../../../core/common/colors.dart";
import "../controllers/splash_screen_controller.dart";

///
class SplashScreenView extends GetView<SplashScreenController> {
  ///
  const SplashScreenView({super.key});
  @override
  String? get tag => splashScreenTag;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Stack(
          children: [
            Positioned(
              left: 10,
              right: 0,
              top: 0,
              bottom: 0,
              child: Lottie.asset(
                "assets/anims/tictactoe.json",
                repeat: true,
                delegates: Theme.of(context).brightness == Brightness.dark
                    ? LottieDelegates(
                        values: [
                          ValueDelegate.colorFilter(
                            ['Line 1', '**'],
                            value: const ColorFilter.mode(
                                Colors.white, BlendMode.src),
                          ),
                          ValueDelegate.colorFilter(
                            ['Line 2', '**'],
                            value: const ColorFilter.mode(
                                Colors.white, BlendMode.src),
                          ),
                          ValueDelegate.colorFilter(
                            ['Line 3', '**'],
                            value: const ColorFilter.mode(
                                Colors.white, BlendMode.src),
                          ),
                          ValueDelegate.colorFilter(
                            ['Line 4', '**'],
                            value: const ColorFilter.mode(
                                Colors.white, BlendMode.src),
                          ),
                        ],
                      )
                    : null,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: controller.animated.value ? 0 : 75,
                    margin: const EdgeInsets.only(left: 50),
                    child: const Text(
                      "TIC",
                      style: TextStyle(
                        color: MColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: controller.animated.value ? 0 : 75,
                    child: const Center(
                      child: Text(
                        "TAC",
                        style: TextStyle(
                          //color: MColors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: controller.animated.value ? 0 : 75,
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.only(right: 50),
                    child: const Text(
                      "TOE",
                      style: TextStyle(
                        color: MColors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 50,
          padding: const EdgeInsets.only(right: 20, bottom: 10),
          alignment: Alignment.centerRight,
          child: Text(
            "version".trParams(
              <String, String>{
                "version": AppInfo.version ?? "",
              },
            ),
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ),
      );
}
