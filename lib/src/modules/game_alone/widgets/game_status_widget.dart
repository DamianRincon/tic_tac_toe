import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/src/core/utils/decode_emoji.dart';

import '../../../core/widgets/player_status_view.dart';
import '../controllers/game_alone_controller.dart';
import '../utils/game_utils.dart';

class GameStatusWidget extends GetWidget<GameAloneController> {
  const GameStatusWidget({super.key});

  @override
  String? get tag => gameAloneControllerTag;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PlayerStatusView(
            width: 95,
            username: controller.isMultiPlayer.value ? 'player1'.tr : 'you'.tr,
            player: GameUtil.PLAYER1,
            wins: controller.player1Win.value,
            flag: controller.preferences.flagForUser,
            urlPhoto: controller.isMultiPlayer.value
                ? null
                : controller.currentUser?.photoURL,
            isSelected: controller.currentPlayer.value == GameUtil.PLAYER1,
          ),
          PlayerStatusView(
            width: 95,
            username: controller.isMultiPlayer.value ? 'player2'.tr : 'bot'.tr,
            player: GameUtil.PLAYER2,
            wins: controller.player2Win.value,
            flag: Utils.defaultIcon,
            isSelected: controller.currentPlayer.value == GameUtil.PLAYER2,
          ),
        ],
      ),
    );
  }
}
