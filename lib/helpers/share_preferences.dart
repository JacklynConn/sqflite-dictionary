import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  late SharedPreferences _preferences;
  final String couterKey = 'counter';

  Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> write(int value) {
    return _preferences.setInt(couterKey, value);
  }

  Future<int> read() async {
    return _preferences.getInt(couterKey) ?? 0;
  }

  Future<bool> remove() async {
    return _preferences.remove(couterKey);
  }

  Future<bool> reset() {
    return _preferences.setInt(couterKey, 0);
  }
}
