import 'package:flutter/material.dart';
import 'package:online_groceries_app/core/services/auth_service.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/home/home_screen.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/login/login_page.dart';

class CheckingLoginStatus extends StatelessWidget {
  CheckingLoginStatus({super.key});

  final prefService = AuthService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: prefService.isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.data == true) {
          return HomeScreen();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
