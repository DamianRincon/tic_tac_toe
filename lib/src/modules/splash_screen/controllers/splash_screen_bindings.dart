import "package:get/get.dart";

import "splash_screen_controller.dart";

///
class SplashScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SplashScreenController.new, tag: splashScreenTag);
  }
}
