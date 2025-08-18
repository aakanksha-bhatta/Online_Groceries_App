import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_groceries_app/features/auth/data/model/user.dart';
import 'package:online_groceries_app/features/auth/presentation/controller/user_notifier.dart';

final passwordVisibilityProvider = StateProvider<bool>((ref) => false); // holding valye

final userListProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) {
  return UserNotifier();
});