import 'package:flutter/material.dart';
import 'package:online_groceries_app/config/constants/app_color.dart';

class AppTheme {
  static ThemeData lightTheme(){
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.green,
      textTheme: TextTheme(
        displayMedium: TextStyle(
          color: AppColor.white
        )
      )
    );
  }
  static ThemeData darkTheme(){
    return ThemeData(
      brightness: Brightness.dark,
    );
  }
}