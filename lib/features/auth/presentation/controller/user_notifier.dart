import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_groceries_app/features/auth/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends StateNotifier<List<User>> {
  final String _usersKey = 'users';

  UserNotifier() : super([]) {
    loadUsers();
  }

  Future<void> loadUsers() async {
    final pref = await SharedPreferences.getInstance();
    final userListJson = pref.getStringList(_usersKey) ?? [];
    // print('%%% Loaded users from SharedPreferences: $userListJson');

    final users = userListJson.map((userJson) {
      final userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
      
    }).toList();

    state = users;
  }

  Future<void> saveUsers(User user) async {
    final pref = await SharedPreferences.getInstance();
    final updatedUsers = [...state, user];
    final userListJson = updatedUsers
        .map((user) => jsonEncode(user.toJson()))
        .toList();
    await pref.setStringList(_usersKey, userListJson);
    state = updatedUsers;
    //print('%%% Saved users: $userListJson');
  }

  bool loginUser(String useremail, String userpassword) {
    final user = state.firstWhere(
      (user) =>
          user.useremail == useremail && user.userpassword == userpassword,
    );

    return user != null;
  }
}
