import 'dart:convert';

import 'package:assignment/data/model/features/user/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _favUsers = 'favUsers';

class SharedPrefs {
  factory SharedPrefs() => SharedPrefs._internal();
  SharedPrefs._internal();
  static SharedPreferences? _sharedPrefs;

  static Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> addUsers({
    required User user,
  }) async {
    if (_sharedPrefs != null) {
      final storedUsers = _sharedPrefs?.getStringList(_favUsers) ?? [];

      await _sharedPrefs?.setStringList(
        _favUsers,
        [...storedUsers, jsonEncode(user.toJson())],
      );
    }
  }

  static Future<void> removeUsers({
    required User user,
  }) async {
    if (_sharedPrefs != null) {
      final storedUsers = _sharedPrefs?.getStringList(_favUsers) ?? [];

      final List<String> updatedFavUsers = List.from(storedUsers)
        ..remove(jsonEncode(user.toJson()));

      await _sharedPrefs?.setStringList(
        _favUsers,
        updatedFavUsers,
      );
    }
  }

  static List<User?> getUsers() {
    List<User?> users = [];
    final storedUsers = _sharedPrefs?.getStringList(_favUsers) ?? [];

    for (var element in storedUsers) {
      users.add(User.fromJson(jsonDecode(element)));
    }

    return users;
  }

  static Future<void> clear() async {
    await _sharedPrefs?.clear();
  }
}
