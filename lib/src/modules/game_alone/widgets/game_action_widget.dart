import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/game_alone_controller.dart';

class GameActionWidget extends GetWidget<GameAloneController> {
  const GameActionWidget({super.key});

  @override
  String? get tag => gameAloneControllerTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: TextButton(
        onPressed: controller.reinitialize,
        style: ButtonStyle(
          minimumSize: MaterialStatePropertyAll<Size>(
            Size(Get.width, 55),
          ),
          shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          backgroundColor: const MaterialStatePropertyAll<Color>(Colors.black),
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
    );
  }
}
