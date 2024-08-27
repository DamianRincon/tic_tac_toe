import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:icons_plus/icons_plus.dart";
import "package:tic_tac_toe/src/core/common/constants_key.dart";
import "package:url_launcher/url_launcher.dart";
import "../../../../core/utils/app_info.dart";
import "../../control/about_of_controller.dart";
import "../widget/custom_btn.dart";

///
class AboutOfView extends GetView<AboutOfController> {
  ///
  const AboutOfView({super.key});

  @override
  String? get tag => aboutOfControllerTag;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("about_of".tr),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: <Widget>[
              Center(
                child: Image.asset(
                  "assets/images/ic_launcher.png",
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                APP_NAME,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                AppInfo.version ?? "",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("made_of".tr),
                    const SizedBox(width: 5),
                    const Icon(
                      BoxIcons.bxs_heart,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Text("made_with".tr),
                    const SizedBox(width: 5),
                    const Icon(
                      BoxIcons.bxl_flutter,
                      size: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomButtonAO(
                    title: "share".tr,
                    icon: const Icon(
                      BoxIcons.bx_share_alt,
                      size: 24,
                    ),
                    onPressed: controller.sharedApp,
                  ),
                  CustomButtonAO(
                    title: "more_apps".tr,
                    icon: const Icon(
                      BoxIcons.bxl_play_store,
                      size: 24,
                    ),
                    onPressed: () => launcherURL(
                      AppInfo.googleStore ?? "",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://github.com/DamianRincon.png",
                  ),
                ),
                title: const Text("Damián Rincón."),
                subtitle: Text("damianrc".tr),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomButtonAO(
                    title: "Twitter",
                    icon: const Icon(
                      BoxIcons.bxl_twitter,
                      size: 24,
                    ),
                    onPressed: () => launcherURL(
                      AppInfo.twitter ?? "",
                    ),
                  ),
                  CustomButtonAO(
                    title: "Facebook",
                    icon: const Icon(
                      BoxIcons.bxl_facebook,
                      size: 24,
                    ),
                    onPressed: () => launcherURL(
                      AppInfo.facebook ?? "",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomButtonAO(
                    title: "Github",
                    icon: const Icon(
                      BoxIcons.bxl_github,
                      size: 24,
                    ),
                    onPressed: () => launcherURL(
                      AppInfo.github ?? "",
                    ),
                  ),
                  CustomButtonAO(
                    title: "Instagram",
                    icon: const Icon(
                      BoxIcons.bxl_instagram,
                      size: 24,
                    ),
                    onPressed: () => launcherURL(
                      AppInfo.instagram ?? "",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  ///
  Future<void> launcherURL(String url) async {
    final Uri uri = Uri.parse(url);
    final bool isValidURL = await canLaunchUrl(uri);
    if (isValidURL) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
