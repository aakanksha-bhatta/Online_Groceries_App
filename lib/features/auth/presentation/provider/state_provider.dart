import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_groceries_app/features/auth/data/model/user.dart';
// import 'package:online_groceries_app/features/auth/presentation/controller/auth_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

final passwordVisibilityProvider = StateProvider<bool>(
  (ref) => false,
); // holding value

// final userListProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) {
//   return UserNotifier();
// });

// final userMobileNoProvider = ChangeNotifierProvider<UserChangeNotifier>((ref) {
//   return UserChangeNotifier(ref);
//   // Notifier.loadUser();
// });

class UserChangeNotifier extends ChangeNotifier {
  UserChangeNotifier({required this.ref});
  final Ref ref;
  List<User> usersData = [];
  bool isLoading = false;
  final String _usersKey = 'users';

  Future<void> loadUsers() async {
    final pref = await SharedPreferences.getInstance();
    final userListJson = pref.getStringList(_usersKey) ?? [];
    // print('%%% Loaded users from SharedPreferences: $userListJson');

    final users = userListJson.map((userJson) {
      final userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }).toList();
    isLoading = true;
    usersData = users;
    notifyListeners();
  }
}
