import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/login/login_page.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/onboarding/onboarding.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/splash/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: Path.splash,
  routes:[
    GoRoute(
      path: Path.splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: Path.onboarding,
      builder: (context, state) => Onboarding(),
    ),
    GoRoute(
      path: Path.login,
      builder: (context, state) => LoginPage(),
    ),    
  ]
);