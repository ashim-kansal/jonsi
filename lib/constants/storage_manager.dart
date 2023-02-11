import 'package:shared_preferences/shared_preferences.dart';

/// To store local storage .
///
/// For e.g userId, access token.
class StorageManager {
  factory StorageManager() {
    return _instance;
  }

  StorageManager._internal();

  static final StorageManager _instance = StorageManager._internal();

  SharedPreferences ?_userPreferences;

  bool get isInitialized => _userPreferences != null;

  Future<void> init() async {
    _userPreferences = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    // organizationId = null;

    await _userPreferences!.clear();
  }


  String get userId => _userPreferences!.getString('userId') ?? '';

  set userId(String apiUrl) {
    _userPreferences!.setString('userId', apiUrl);
  }

  String get name => _userPreferences!.getString('name') ?? '';

  set name(String s) {
    _userPreferences!.setString('name', s);
  }

  String get email => _userPreferences!.getString('email') ?? '';

  set email(String s) {
    _userPreferences!.setString('email', s);
  }

  String get nationality => _userPreferences!.getString('nationality') ?? '';

  set nationality(String s) {
    _userPreferences!.setString('nationality', s);
  }

  String get language => _userPreferences!.getString('language') ?? '';

  set language(String s) {
    _userPreferences!.setString('language', s);
  }

  bool get isProvider => _userPreferences!.getBool('isProvider') ?? false;

  set isProvider(bool s) {
    _userPreferences!.setBool('isProvider', s);
  }

  String get accessToken => _userPreferences!.getString('accessToken') ?? '';

  set accessToken(String data) {
    _userPreferences!.setString('accessToken', data);
  }
}
