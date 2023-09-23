import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends StorageServiceValues {
  static StorageService instance = StorageService();
  static const String _userGroupKey = 'user_group';

  late SharedPreferences _preferences;

  static Future<void> initialize() async {
    instance._preferences = await SharedPreferences.getInstance();

    await instance.read();
  }

  Future<void> read() async {
    userGroup = _preferences.getString(_userGroupKey) ?? '';
  }

  Future<void> writeUserGroup(String value) async {
    await _preferences.setString(_userGroupKey, value);
  }

  Future<void> deleteUserGroup() async {
    await _preferences
        .remove(_userGroupKey)
        .then((value) => instance.userGroup = '');
  }
}

class StorageServiceValues {
  late String userGroup;
}
