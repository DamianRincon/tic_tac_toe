import "dart:developer";
import "package:firebase_auth/firebase_auth.dart";
import "package:get/get.dart";

import "../../../core/routes/routes.dart";

///
const String splashScreenTag = "splash_screen_controller";

///
class SplashScreenController extends GetxController {
  ///
  RxBool animated = true.obs;

  @override
  Future<void> onInit() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
      () {
        animated.value = false;
      },
    );
    Future<void>.delayed(const Duration(seconds: 2), validateSession);
    super.onInit();
  }

  ///
  Future<void> validateSession() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        log("Validate Session: User is currently signed out!");
        await Get.offAndToNamed(Routes.login);
      } else {
        await Get.offAndToNamed(Routes.home);
        log("Validate Session: User is signed in!");
      }
    });
  }
}
