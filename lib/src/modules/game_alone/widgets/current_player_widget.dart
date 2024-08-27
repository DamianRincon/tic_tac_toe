import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/game_alone_controller.dart';
import '../utils/game_utils.dart';
import '../../../core/widgets/circle_widget.dart';
import '../../../core/widgets/cross_widget.dart';

class CurrentPlayerWidget extends GetWidget<GameAloneController> {
  const CurrentPlayerWidget({super.key});
  @override
  String? get tag => gameAloneControllerTag;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
          width: 20.0,
          child: Obx(
            () => _getPlayerSymbol(controller.currentPlayer.value),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Text(
            controller.currentPlayerMove ?? "",
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  Widget _getPlayerSymbol(int playerId) {
    switch (playerId) {
      case GameUtil.PLAYER1:
        return const CrossWidget(
          strokeWidth: 6.0,
        );
      case GameUtil.PLAYER2:
        return const CircleWidget(
          strokeWidth: 6.0,
        );
      default:
        throw ArgumentError("Unknow playerId");
    }
  }
}
