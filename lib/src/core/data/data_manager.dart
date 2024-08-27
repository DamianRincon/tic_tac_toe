import "package:shared_preferences/shared_preferences.dart";

///
class SharedManager {
  ///
  factory SharedManager() => _instance ??= SharedManager._();
  SharedManager._();

  static SharedManager? _instance;

  ///
  late SharedPreferences? box;

  ///
  Future<void> init() async {
    print("INIT SharedManager");
    box = await SharedPreferences.getInstance();
  }

  ///
  Future<void> put(String key, dynamic value) async {
    final SharedPreferences? prefs = box;
    switch (value.runtimeType) {
      case String:
        await prefs?.setString(key, value);
        break;
      case int:
        await prefs?.setInt(key, value);
        break;
      case double:
        await prefs?.setDouble(key, value);
        break;
      case bool:
        await prefs?.setBool(key, value);
        break;
      default:
        await prefs?.setString(key, value);
        break;
    }
  }

  ///
  dynamic get(String key, {required Type type, dynamic defaultValue}) {
    final SharedPreferences? prefs = box;
    switch (type) {
      case String:
        return prefs?.getString(key) ?? defaultValue;
      case int:
        return prefs?.getInt(key) ?? defaultValue;
      case double:
        return prefs?.getDouble(key) ?? defaultValue;
      case bool:
        return prefs?.getBool(key) ?? defaultValue;
      default:
        return null;
    }
  }

  ///
  Future<void> destroy() async {
    final SharedPreferences? prefs = box;
    await prefs?.clear();
  }
}
