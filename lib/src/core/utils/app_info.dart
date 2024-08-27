import "package:flutter/services.dart";
import "package:yaml/yaml.dart";

///
class AppInfo {
  ///
  factory AppInfo() => _instance;
  AppInfo._();
  static final AppInfo _instance = AppInfo._();

  ///
  static Future<void> load() async {
    final String yamlString = await rootBundle.loadString("env.yaml");
    final dynamic parsedYaml = loadYaml(yamlString);
    version = parsedYaml["version"];
    facebook = parsedYaml["facebook"];
    instagram = parsedYaml["instagram"];
    twitter = parsedYaml["twitter"];
    github = parsedYaml["github"];
    keyBanner = parsedYaml["key_banner"];
    keyInters = parsedYaml["key_instersant"];
    showBanner = parsedYaml["show_banner"];
    googleStore = parsedYaml["google_store"];
    appLink = parsedYaml["app_link_store"];
    terms = parsedYaml["terms_link"];
    googleClientID = parsedYaml["google_client_id"];
  }

  ///
  static String? version;

  ///
  static String? facebook;

  ///
  static String? instagram;

  ///
  static String? twitter;

  ///
  static String? github;

  ///
  static bool? showBanner;

  ///
  static String? appLink;

  ///
  static String? terms;

  /// Remote info Firebase
  static String? keyBanner;

  /// Remote info Firebase
  static String? keyInters;

  /// Remote info Firebase
  static String? googleStore;
  static String? googleClientID;
}
