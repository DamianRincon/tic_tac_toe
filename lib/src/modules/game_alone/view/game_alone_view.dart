import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tic_tac_toe/src/core/common/colors.dart';
import 'package:tic_tac_toe/src/core/utils/app_info.dart';
import 'package:tic_tac_toe/src/modules/game_alone/controllers/game_alone_controller.dart';

import '../widgets/board.dart';
import '../widgets/game_action_widget.dart';
import '../widgets/game_status_widget.dart';

class GameAloneView extends GetView<GameAloneController> {
  const GameAloneView({super.key});

  @override
  String? get tag => gameAloneControllerTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar:
          (AppInfo.showBanner == true && controller.bannerAd != null)
              ? SizedBox(
                  width: controller.bannerAd!.sizes[0].width.toDouble(),
                  height: controller.bannerAd!.sizes[0].height.toDouble(),
                  child: AdWidget(ad: controller.bannerAd!),
                )
              : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              const GameStatusWidget(),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 30,
                ),
                color: MColors.tertiary,
                width: Get.width,
                alignment: Alignment.center,
                height: 0.8,
              ),
              controller.isMultiPlayer.value
                  ? const SizedBox(height: 20)
                  : Text(
                      "level".trParams(
                        {
                          "nivel": '${controller.level}'.tr,
                        },
                      ),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              const SizedBox(height: 20),
              BoardWidget(size: MediaQuery.of(context).size.width * 0.76),
              const Spacer(),
              const GameActionWidget(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
