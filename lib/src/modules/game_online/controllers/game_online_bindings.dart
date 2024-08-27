import 'package:get/get.dart';

import 'game_online_controller.dart';

class GameOnlineBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(GameOnlineController.new, tag: gameOnlineControllerTag);
  }
}
