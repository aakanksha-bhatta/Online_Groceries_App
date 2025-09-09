import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_provider.dart';

class CustomNavigationBar extends ConsumerWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
=======
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
>>>>>>> master
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
        boxShadow: [
          BoxShadow(
            color: Color(0x555E5817),
            offset: Offset(2, -5),
            blurRadius: 15,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
        child: NavigationBar(
          backgroundColor: Colors.white,
          height: 92.h,
<<<<<<< HEAD
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            ref.read(selectedIndexProvider.notifier).state = index;

            switch (index) {
              case 0:
                context.go(Path.home);
                break;
              case 1:
                context.go(Path.explore);
                break;
              case 2:
                context.go(Path.cart);
                break;
              case 3:
                context.go(Path.favorite);
                break;
              case 4:
                context.go(Path.account);
                break;
            }
          },

=======
          selectedIndex: 0,
          onDestinationSelected: (int index) {},
>>>>>>> master
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
            final isSelected = states.contains(WidgetState.selected);

            return TextStyle(
              color: isSelected ? Color(0xff53B175) : Color(0xff181725),
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            );
          }),

          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/shop.svg'),
              selectedIcon: SvgPicture.asset(
                'assets/icons/shop.svg',
                color: Color(0xff53B175),
              ),
              label: 'Shop',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/explore.svg'),
              selectedIcon: SvgPicture.asset(
                'assets/icons/explore.svg',
                color: Color(0xff53B175),
              ),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/cart.svg'),
              selectedIcon: SvgPicture.asset(
                'assets/icons/cart.svg',
                color: Color(0xff53B175),
              ),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/favorite.svg'),
              selectedIcon: SvgPicture.asset(
                'assets/icons/favorite.svg',
                color: Color(0xff53B175),
              ),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/account.svg'),
              selectedIcon: SvgPicture.asset(
                'assets/icons/account.svg',
                color: Color(0xff53B175),
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
