import "package:get/get.dart";

import "sign_up_controller.dart";

///
class SignUpBindinds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SignUpController.new, tag: signUpTag);
  }
}
