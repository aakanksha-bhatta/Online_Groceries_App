import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_groceries_app/core/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthNotifier extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    return ref.read(authServiceProvider).getCurrentUser();
  }

  Future<User?> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    final authService = ref.read(authServiceProvider);

    try {
      final user = await authService.signInWithEmailAndPassword(
        email,
        password,
      );
      if (user != null) {
        state = AsyncData(user);
        return user;
      } else {
        state = AsyncError('Invalid email or password.', StackTrace.current);
        return null;
      }
    } on FirebaseAuthException catch (e, st) {
      if (e.code == 'email-already-in-use') {
        print('This email is already registered. Try logging in instead.');
      } else {
        state = AsyncError(e, st);
        return null;
      }
    }
  }

  Future<User?> createWithEmail(String email, String password) async {
    state = const AsyncLoading();
    final authService = ref.read(authServiceProvider);

    try {
      final userCredential = await authService.createUserWithEmailPassword(
        email,
        password,
      );

      if (userCredential?.user != null) {
        state = AsyncData(userCredential?.user);
        return userCredential?.user;
      } else {
        state = AsyncError('Invalid email or password.', StackTrace.current);
        return null;
      }
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    state = const AsyncLoading();
    final authService = ref.read(authServiceProvider);

    try {
      final userCredential = await authService.signInWithGoogle();
      state = AsyncData(userCredential?.user);
      return userCredential?.user;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    final authService = ref.read(authServiceProvider);
    try {
      await authService.signOut();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, User?>(
  () => AuthNotifier(),
);

// import 'dart:convert';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:online_groceries_app/features/auth/data/model/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserNotifier extends StateNotifier<List<User>> {
//   final String _usersKey = 'users';

//   UserNotifier() : super([]) {
//     loadUsers();
//   }

//   Future<void> loadUsers() async {
//     final pref = await SharedPreferences.getInstance();
//     final userListJson = pref.getStringList(_usersKey) ?? [];
//     // print('%%% Loaded users from SharedPreferences: $userListJson');

//     final users = userListJson.map((userJson) {
//       final userMap = jsonDecode(userJson);
//       return User.fromJson(userMap);
//     }).toList();

//     state = users;
//   }

//   Future<void> saveUsers(User user) async {
//     final pref = await SharedPreferences.getInstance();
//     final updatedUsers = [...state, user];
//     final userListJson = updatedUsers
//         .map((user) => jsonEncode(user.toJson()))
//         .toList();
//     await pref.setStringList(_usersKey, userListJson);
//     state = updatedUsers;
//     //print('%%% Saved users: $userListJson');
//   }

//   bool loginUser(String useremail, String userpassword) {
//     final user = state.firstWhere(
//       (user) =>
//           user.useremail == useremail && user.userpassword == userpassword,
//     );

//     return user != null;
//   }
// }
