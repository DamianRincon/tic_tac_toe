import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/src/modules/game_online/controllers/game_online_controller.dart';

class WaitingPlayersMessage extends GetWidget<GameOnlineController> {
  const WaitingPlayersMessage({super.key});
  @override
  String? get tag => gameOnlineControllerTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/anims/loader.json", width: 80, height: 80),
          Text(
            "waiting_for_players".tr,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 100),
          InkWell(
            onTap: controller.exit,
            child: Container(
              width: 100,
              height: 50,
              alignment: Alignment.center,
              child: Text(
                "exit".tr,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
