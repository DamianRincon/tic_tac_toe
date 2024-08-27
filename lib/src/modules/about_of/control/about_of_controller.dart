import "package:get/get.dart";
import "package:share_plus/share_plus.dart";
import "package:tic_tac_toe/src/core/common/constants_key.dart";
import "package:tic_tac_toe/src/core/utils/app_info.dart";

///
const String aboutOfControllerTag = "about_of_controller_tag";

/// Controller
class AboutOfController extends GetxController {
  ///
  Future<void> sharedApp() async {
    await Share.share(
      "share_text".trParams({
        "link": AppInfo.appLink ?? "",
      }),
      subject: APP_NAME,
    );
  }
}
