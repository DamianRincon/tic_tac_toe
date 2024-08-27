import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../../core/common/theme.dart";
import "../../../core/data/data_manager.dart";
import "../../../core/data/preferences.dart";
import "../widgets/menu_option.dart";

///
const String settingsControllerTag = "settings_controller_tag";

///
class SettingsController extends GetxController {
  ///
  String title = "settings".tr;

  ///
  User? currentUser = FirebaseAuth.instance.currentUser;

  ///
  RxString theme = "".obs;

  ///
  final Preferences _preferences = Preferences();
  RxString flagUser = "".obs;
  RxString languajeUser = "".obs;

  @override
  void onInit() {
    init();
    flagUser(_preferences.flagForUser);
    theme(_preferences.themeModeApp);
    languajeUser(_preferences.language.toUpperCase());
    super.onInit();
  }

  Future<void> init() async {
    await SharedManager().init();
  }

  // ignore: type_annotate_public_apis
  ///
  List<MenuOptionsModel> themeOptions() => <MenuOptionsModel>[
        MenuOptionsModel(
          key: "system",
          value: "system".tr,
          icon: Icons.brightness_4,
        ),
        MenuOptionsModel(
          key: "light",
          value: "light".tr,
          icon: Icons.brightness_low,
        ),
        MenuOptionsModel(
          key: "dark",
          value: "dark".tr,
          icon: Icons.brightness_3,
        )
      ];

  ///
  void changeTheme(String? value) {
    theme(value);
    _preferences.themeModeApp = value ?? "";
    Get.changeThemeMode(themeMode(value ?? ""));
  }

  void changeFlag(String value) {
    flagUser(value);
    _preferences.flagForUser = value;
  }

  void changeLanguaje(String? value) {
    if (value != null && value.isNotEmpty) {
      languajeUser(value);
      _preferences.language = value.toLowerCase();
      Get.updateLocale(Locale(value.toLowerCase()));
    }
  }
}
