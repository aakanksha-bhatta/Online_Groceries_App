import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/home/home_screen.dart';
=======
import 'package:online_groceries_app/features/auth/presentation/pages/home/home_screen.dart';
>>>>>>> master
import 'package:online_groceries_app/features/auth/presentation/pages/splash/splash_screen.dart';

class CheckingLoginStatus extends StatelessWidget {
  const CheckingLoginStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          return const HomeScreen();
        }
        return const SplashScreen();
      },
    );
  }
}
