import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordVisibilityProvider = StateProvider<bool>(
  (ref) => false,
); // holding value of password visibility

final selectedIndexProvider = StateProvider<int>(
  (ref) => 0,
); // holding  value for navigation bar

final selectedFavoriteProvider = StateProvider<int>(
  (ref) => Color(0xFF7C7C7C).value,
); // handling favorite selection

final currentRatingProvider = StateProvider<int>((ref) => 0); // handling rating

final quantityProvider = StateProvider<int>((ref) => 1); // handling quantity

final productDetailsVisibleProvider = StateProvider<bool>((ref) => false);
// handling product details visibility
final nutritionDetailsVisibleProvider = StateProvider<bool>((ref) => false);

final deleteItemProvider = StateProvider<bool>((ref) => false);
// final userListProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) {
//   return UserNotifier();
// });

// final userMobileNoProvider = ChangeNotifierProvider<UserChangeNotifier>((ref) {
//   return UserChangeNotifier(ref);
//   // Notifier.loadUser();
// });

// class UserChangeNotifier extends ChangeNotifier {
//   UserChangeNotifier({required this.ref});
//   final Ref ref;
//   List<User> usersData = [];
//   bool isLoading = false;
//   final String _usersKey = 'users';

//   Future<void> loadUsers() async {
//     final pref = await SharedPreferences.getInstance();
//     final userListJson = pref.getStringList(_usersKey) ?? [];
//     // print('%%% Loaded users from SharedPreferences: $userListJson');

//     final users = userListJson.map((userJson) {
//       final userMap = jsonDecode(userJson);
//       return User.fromJson(userMap);
//     }).toList();
//     isLoading = true;
//     usersData = users;
//     notifyListeners();
//   }
// }
