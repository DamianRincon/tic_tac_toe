import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class SelectLevel extends StatelessWidget {
  SelectLevel({super.key, this.selectLevel});

  Function(String)? selectLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
              onPressed: Get.back, icon: const Icon(AntDesign.close_outline)),
          const SizedBox(width: 20),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "choose_level".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(width: Get.width),
          const SizedBox(height: 50),
          _customButton(
              "easy".tr, () => selectLevel!("easy"), const SizedBox()),
          const SizedBox(height: 20),
          _customButton(
              "medium".tr, () => selectLevel!("medium"), const SizedBox()),
          const SizedBox(height: 20),
          _customButton(
              "hard_core".tr,
              () => selectLevel!("hard_core"),
              const Icon(
                AntDesign.fire_outline,
                color: Colors.white,
              )),
        ],
      ),
    );
  }

  Widget _customButton(String title, Function()? onTap, icon) =>
      TextButton.icon(
        onPressed: onTap,
        icon: icon,
        style: ButtonStyle(
          minimumSize: const MaterialStatePropertyAll<Size>(
            Size(150, 45),
          ),
          shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          backgroundColor: const MaterialStatePropertyAll<Color>(Colors.black),
        ),
        label: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
