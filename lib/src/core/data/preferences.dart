import "package:get/get.dart";

import "../common/constants_key.dart";
import "data_manager.dart";

///
class Preferences {
  ///
  factory Preferences() => _instance ??= Preferences._();

  Preferences._() : manager = SharedManager();

  static Preferences? _instance;

  ///
  final SharedManager manager;

  ///
  bool get showOnboarding => manager.get(
        SHOW_ONBOARDING,
        type: bool,
        defaultValue: true,
      );

  ///
  set showOnboarding(bool value) => manager.put(SHOW_ONBOARDING, value);

  ///
  String get language => manager.get(
        LANGUAGE,
        type: String,
        defaultValue: Get.deviceLocale?.languageCode,
      );

  ///
  set language(String value) => manager.put(LANGUAGE, value);

  ///
  String get themeModeApp => manager.get(
        THEME_MODE,
        type: String,
        defaultValue: "system",
      );

  ///
  set themeModeApp(String value) => manager.put(THEME_MODE, value);

  ///
  String get flagForUser =>
      manager.get(FLAG, type: String, defaultValue: "\uD83C\uDF0D");

  ///
  set flagForUser(String value) => manager.put(FLAG, value);
}
