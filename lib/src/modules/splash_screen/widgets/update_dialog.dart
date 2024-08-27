// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:get/get.dart";

///
class UpdateDialog extends StatelessWidget {
  ///
  UpdateDialog(this.versionLocal, this.versionStore, this.releaseNote,
      {super.key});

  ///
  String versionLocal;

  ///
  String versionStore;

  ///
  String releaseNote;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(
          top: 10,
          right: 15,
          left: 15,
        ),
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "update_title".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: Image.asset("assets/icons/60.png"),
                ),
                const SizedBox(height: 20),
                Text(
                  "update_header".tr,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "version_actualy".trParams(
                    <String, String>{
                      "version": versionLocal,
                    },
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "version_store".trParams(
                    <String, String>{
                      "version": versionStore,
                    },
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "update_content".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List<Widget>.generate(
                    releaseNote.split(":").length,
                    (int index) => Text(
                      releaseNote.split(":")[index],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 30,
              right: 0,
              left: 0,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.black),
                  fixedSize: MaterialStatePropertyAll<Size>(
                    Size(Get.width, 40),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "update_now".tr,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
