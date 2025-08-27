import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/services/checking_login_status.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/home/home_screen.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/login/login_page.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/onboarding/onboarding.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/signin/location.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/signin/mobile_number_screen.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/signin/signin_screen.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/signin/verification.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/signup/signup_screen.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/splash/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: Path.loginStatus,
  routes: [
    GoRoute(
      path: Path.loginStatus,
      builder: (context, state) => CheckingLoginStatus(),
    ),
    GoRoute(path: Path.splash, builder: (context, state) => SplashScreen()),
    GoRoute(path: Path.onboarding, builder: (context, state) => Onboarding()),
    GoRoute(path: Path.login, builder: (context, state) => LoginPage()),
    GoRoute(path: Path.signup, builder: (context, state) => SignupScreen()),
    GoRoute(path: Path.home, builder: (context, state) => HomeScreen()),
    GoRoute(path: Path.signin, builder: (context, state) => SigninScreen()),
    GoRoute(
      path: Path.mobile,
      builder: (context, state) => MobileNumberScreen(),
    ),
    GoRoute(
      path: Path.verification,
      builder: (context, state) => Verification(),
    ),
    GoRoute(path: Path.location, builder: (context, state) => Location()),
  ],
);
