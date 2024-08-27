import 'package:flutter/material.dart';

import '../../modules/game_alone/utils/game_utils.dart';
import '../common/colors.dart';
import '../utils/decode_emoji.dart';
import 'circle_widget.dart';
import 'cross_widget.dart';

class PlayerStatusView extends StatelessWidget {
  const PlayerStatusView({
    super.key,
    required this.username,
    required this.player,
    required this.wins,
    required this.isSelected,
    required this.flag,
    this.urlPhoto,
    this.width = 85,
  });

  final String username;
  final int player;
  final int wins;
  final bool isSelected;
  final String flag;
  final String? urlPhoto;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: isSelected ? 25 : 0,
      borderRadius: BorderRadius.circular(10),
      shadowColor: MColors.tertiary,
      child: Container(
        height: 127,
        width: width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                urlPhoto != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          urlPhoto!,
                          width: 50,
                          height: 50,
                        ),
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: MColors.secondaryContainer,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    child: Utils.emojiText(
                      flag,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              username,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              height: 1,
              width: 85,
              color: MColors.tertiaryContainer,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: player == GameUtil.PLAYER1 ? 15 : 18,
                  height: player == GameUtil.PLAYER1 ? 15 : 18,
                  child: _getPlayerSymbol(player),
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: MColors.tertiaryContainer,
                ),
                Text(
                  "$wins",
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPlayerSymbol(int playerId) {
    switch (playerId) {
      case GameUtil.PLAYER1:
        return const CrossWidget(
          strokeWidth: 5,
        );
      case GameUtil.PLAYER2:
        return const CircleWidget(
          strokeWidth: 5,
        );
      default:
        throw ArgumentError("Unknow playerId");
    }
  }
}
