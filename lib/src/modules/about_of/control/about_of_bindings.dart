import "package:get/get.dart";

import "about_of_controller.dart";

/// Bindings
class AboutOfBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutOfController>(AboutOfController.new,
        tag: aboutOfControllerTag);
  }
}
