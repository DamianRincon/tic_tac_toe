import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/src/core/common/colors.dart';
import 'package:tic_tac_toe/src/core/widgets/circle_widget.dart';
import 'package:tic_tac_toe/src/modules/game_online/controllers/game_online_controller.dart';

import '../../../core/widgets/cross_widget.dart';
import '../../game_alone/utils/game_utils.dart';

const borderWidth = 1.6;
const borderColor = Colors.grey;
const borderStyle = BorderStyle.solid;

class BoardOnlineWidget extends GetWidget<GameOnlineController> {
  @override
  String? get tag => gameOnlineControllerTag;

  final double size;
  const BoardOnlineWidget({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.square(size),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _listenBoardData(),
          _listenGameResult(),
        ],
      ),
    );
  }

  Widget _listenGameResult() {
    return Obx(
      () => IgnorePointer(
        ignoring: controller.gameResult.value == 0,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.center,
          color: controller.gameResult.value != 0
              ? Colors.grey.withOpacity(0.2)
              : Colors.transparent,
          child: _buildForGameResult(),
        ),
      ),
    );
  }

  Widget? _buildForGameResult() {
    final gameResultStatus = controller.gameResultStatus;
    if (gameResultStatus != null) {
      return Text(
        gameResultStatus,
        style: const TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    return null;
  }

  Widget _listenBoardData() {
    return Obx(
      () => AnimationLimiter(
        key: controller.boardKey,
        child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          childAspectRatio: 1.0,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            controller.board.length,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 3,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: _Field(
                      index: index,
                      onTap: (idx) {
                        controller.makeMove(idx);
                      },
                      isEnable: controller.isEnable(index),
                      playerId: controller.getDataAt(index),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final int index;
  final bool isEnable;
  final ValueChanged<int> onTap;
  final int playerId;
  const _Field({
    required this.index,
    required this.isEnable,
    required this.onTap,
    required this.playerId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: isEnable ? 2 : 10,
        shadowColor: MColors.secondaryContainer,
        child: InkWell(
          splashColor: MColors.secondary,
          focusColor: MColors.secondary,
          hoverColor: MColors.secondary,
          highlightColor: MColors.secondary,
          borderRadius: BorderRadius.circular(10),
          onTap: isEnable ? () => onTap(index) : null,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: _getPlayerWidget(playerId),
          ),
        ),
      ),
    );
  }

  Widget? _getPlayerWidget(int playerId) {
    switch (playerId) {
      case GameUtil.PLAYER1:
        return const CrossWidget();
      case GameUtil.PLAYER2:
        return const CircleWidget();
      default:
        return null;
    }
  }
}
