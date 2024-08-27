import 'package:get/get.dart';

import 'game_alone_controller.dart';

///
class GameAloneBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(GameAloneController.new, tag: gameAloneControllerTag);
  }
}
