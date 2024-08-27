import 'package:get/get.dart';

import 'rules_controller.dart';

class RulessBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RulesController>(RulesController.new, tag: rulesControllerTag);
  }
}
