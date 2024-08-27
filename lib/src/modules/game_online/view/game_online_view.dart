import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tic_tac_toe/src/core/common/colors.dart';
import 'package:tic_tac_toe/src/core/common/constants_key.dart';
import 'package:tic_tac_toe/src/modules/game_online/widgets/board.dart';

import '../../../core/utils/app_info.dart';
import '../widgets/waiting_players.dart';
import '../controllers/game_online_controller.dart';
import '../widgets/game_action_widget.dart';
import '../widgets/game_status_widget.dart';

const borderWidth = 1.6;
const borderColor = Colors.grey;
const borderStyle = BorderStyle.solid;

class GameOnlineView extends GetView<GameOnlineController> {
  const GameOnlineView({super.key});

  @override
  String? get tag => gameOnlineControllerTag;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar:
            (AppInfo.showBanner == true && controller.bannerAd != null)
                ? SizedBox(
                    width: controller.bannerAd!.sizes[0].width.toDouble(),
                    height: controller.bannerAd!.sizes[0].height.toDouble(),
                    child: AdWidget(ad: controller.bannerAd!),
                  )
                : null,
        body: StreamBuilder<DocumentSnapshot>(
          stream: controller.firestore
              .collection(DATABASE)
              .doc(controller.myRoom.value)
              .snapshots(),
          builder: (_, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                Get.context!.loaderOverlay.show(
                  widgetBuilder: (_) => const WaitingPlayersMessage(),
                );
                break;
              default:
                Get.context!.loaderOverlay.show(
                  widgetBuilder: (_) => const WaitingPlayersMessage(),
                );
            }
            if (snapshot.hasData && snapshot.data!.exists) {
              Map<String, dynamic> gameData =
                  snapshot.data!.data() as Map<String, dynamic>;
              controller.board.value = (gameData["board"]).cast<int>();
              controller.validateData(gameData);
              Get.context!.loaderOverlay.show(
                widgetBuilder: (_) => const WaitingPlayersMessage(),
              );

              if (gameData["status"] == "waiting") {
                Get.context!.loaderOverlay.show(
                  widgetBuilder: (_) => const WaitingPlayersMessage(),
                );
              } else if (gameData["status"] == "game_over") {
                Get.context!.loaderOverlay.hide();
                Get.back();
              } else {
                controller.checkGameWinner();
                Get.context!.loaderOverlay.hide();
              }

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: <Widget>[
                      const GameStatusWidgetOnline(),
                      const Spacer(),
                      Container(
                        color: MColors.tertiary,
                        width: Get.width,
                        alignment: Alignment.center,
                        height: 0.8,
                      ),
                      const Spacer(),
                      const Spacer(),
                      BoardOnlineWidget(size: Get.size.width * 0.76),
                      const Spacer(),
                      const GameActionOnlineWidget(),
                      const Spacer(),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
