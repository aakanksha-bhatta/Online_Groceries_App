import 'package:flutter/material.dart';
import 'package:online_groceries_app/config/constants/app_color.dart';

class AppTheme {
  static ThemeData lightTheme(){
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.green,
    );
  }
  static ThemeData darkTheme(){
    return ThemeData(
      brightness: Brightness.dark,
    );
  }
}