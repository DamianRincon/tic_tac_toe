import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'langs/en.dart';
import 'langs/es.dart';

class Strings extends Translations {
  @override

  ///
  Map<String, Map<String, String>> get keys => <String, Map<String, String>>{
        "en": enTranslation,
        "es": esTranslation,
      };
}
