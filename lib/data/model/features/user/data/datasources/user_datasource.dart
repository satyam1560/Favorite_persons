import 'dart:convert';

import 'package:assignment/data/model/features/user/data/models/user.dart';
import 'package:http/http.dart' as http;

class UserDataSource {
  Future<List<User>> getUserDetails() async {
    List<User> usersList = [];
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      final data = result['data'];
      for (var user in data) {
        usersList.add(User.fromJson(user));
      }
    }

    return usersList;
  }
}
