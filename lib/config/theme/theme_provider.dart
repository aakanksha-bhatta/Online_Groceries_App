import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefenceProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

final themeSwitchProvider = StateProvider<bool>((ref) {
  final sharedPreference = ref.watch(sharedPrefenceProvider);
  final theme = sharedPreference.value?.getString('themeMode');
  return theme == 'dark' ? true : false;
});

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final sharedPreference = ref.watch(sharedPrefenceProvider);
  final themeSwitch = ref.watch(themeSwitchProvider);

  if (themeSwitch) {
    sharedPreference.value?.setString('themeMode', 'dark');
  } else {
    sharedPreference.value?.setString('themeMode', 'light');
  }

  final theme = sharedPreference.value?.getString('themeMode');
  return theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
});
