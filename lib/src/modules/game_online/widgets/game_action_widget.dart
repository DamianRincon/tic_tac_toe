import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/src/modules/game_online/controllers/game_online_controller.dart';

class GameActionOnlineWidget extends GetWidget<GameOnlineController> {
  const GameActionOnlineWidget({super.key});

  @override
  String? get tag => gameOnlineControllerTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          TextButton(
            onPressed: controller.reinitialize,
            style: ButtonStyle(
              minimumSize: MaterialStatePropertyAll<Size>(
                Size(Get.width, 55),
              ),
              shape: MaterialStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              backgroundColor:
                  const MaterialStatePropertyAll<Color>(Colors.black),
            ),
            child: Text(
              "restart".tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: controller.gameOver,
            style: ButtonStyle(
              minimumSize: MaterialStatePropertyAll<Size>(
                Size(Get.width, 40),
              ),
              shape: MaterialStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              backgroundColor:
                  const MaterialStatePropertyAll<Color>(Colors.transparent),
            ),
            child: Text(
              "game_over".tr,
              style: const TextStyle(
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
