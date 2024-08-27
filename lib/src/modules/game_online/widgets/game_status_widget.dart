import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/src/modules/game_alone/utils/game_utils.dart';
import 'package:tic_tac_toe/src/modules/game_online/controllers/game_online_controller.dart';

import '../../../core/widgets/player_status_view.dart';

class GameStatusWidgetOnline extends GetWidget<GameOnlineController> {
  const GameStatusWidgetOnline({super.key});

  @override
  String? get tag => gameOnlineControllerTag;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PlayerStatusView(
            username: controller.player1Name.value,
            player: GameUtil.PLAYER1,
            wins: controller.player1Win.value,
            flag: controller.player1Flag.value,
            isSelected: controller.currentPlayer.value == GameUtil.PLAYER1,
          ),
          PlayerStatusView(
            username: controller.player2Name.value,
            player: GameUtil.PLAYER2,
            wins: controller.player2Win.value,
            flag: controller.player2Flag.value,
            isSelected: controller.currentPlayer.value == GameUtil.PLAYER2,
          ),
        ],
      ),
    );
  }
}
