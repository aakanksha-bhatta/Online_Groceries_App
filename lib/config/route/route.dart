import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/services/checking_login_status.dart';
import 'package:online_groceries_app/features/auth/data/enum/product_enum.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/account/account.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/account/chat/chat_user_list.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/account/details.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/account/order.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/cart/cart_page.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/cart/order_accepted.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/explore/category.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/explore/explore_product_page.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/explore/filtered_product_page.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/explore/product_item.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/favourite/favourite_page.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/home/home_screen.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/home/product_details_page.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/home/search_see_all_page.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/login/login_page.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/onboarding/onboarding.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/practice/practice.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/setting/setting_screen.dart';
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
    GoRoute(path: Path.setting, builder: (context, state) => SettingScreen()),
    GoRoute(
      path: Path.productDetails,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return ProductDetailsPage(
          productId: extra['productId'],
          productName: extra['productName'],
          productImage: extra['productImage'],
          productPrice: extra['productPrice'],
          productQuantity: extra['productQuantity'],
        );
      },
    ),

    GoRoute(
      path: Path.explore,
      builder: (context, state) => ExploreProductPage(),
    ),
    GoRoute(path: Path.cart, builder: (context, state) => CartPage()),
    GoRoute(path: Path.favorite, builder: (context, state) => FavoritePage()),
    GoRoute(path: Path.account, builder: (context, state) => Account()),
    GoRoute(path: Path.order, builder: (context, state) => OrderAccepted()),
    GoRoute(
      path: Path.item,
      builder: (context, state) {
        final categoryName = state.uri.queryParameters['category'];

        final categoryEnum = ProductEnum.values.firstWhere(
          (e) => e.name == categoryName,
          orElse: () => ProductEnum.freshfruitvegetable,
        );

        return ProductListPage(category: categoryEnum);
      },
    ),

    GoRoute(path: Path.category, builder: (context, state) => Category()),
    GoRoute(path: Path.see, builder: (context, state) => SearchSeeAllPage()),
    GoRoute(path: Path.user, builder: (context, state) => UserList()),
    GoRoute(path: Path.practice, builder: (context, state) => Practice()),
    GoRoute(path: Path.details, builder: (context, state) => Details()),
    GoRoute(path: Path.accorder, builder: (context, state) => Order()),
    GoRoute(
      path: '/filtered-products',
      builder: (context, state) {
        final selectedCategories = state.extra as List<String>? ?? [];
        return FilteredProductPage(selectedCategories: selectedCategories);
      },
    ),
  ],
);
