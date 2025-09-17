import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/services/auth_service.dart';
import 'package:online_groceries_app/features/auth/presentation/controller/auth_notifier.dart';
// import 'package:online_groceries_app/features/auth/presentation/provider/change_notifier.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_navigation_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_snack_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class Account extends ConsumerWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authNotifierProvider);
    // final userDataAsync = ref.watch(userDataProvider);
    // final loading = ref.watch(loadingProvider);
    // final currentUser = ref.watch(authServiceProvider);

    final List<Map<String, dynamic>> accountItems = [
      {
        'icon': Icons.shopping_bag_outlined,
        'title': 'Orders',
        'route': Path.accorder,
      },
      {
        'icon': Icons.person_outline,
        'title': 'My Details',
        'route': Path.details,
      },
      {'icon': Icons.chat, 'title': 'Chat', 'route': Path.user},
      {'icon': Icons.location_on_outlined, 'title': 'Delivery Address'},
      // {'icon': Icons.payment_outlined, 'title': 'Payment Methods'},
      // {'icon': Icons.chat, 'title': 'Chat', 'route': Path.user},
      // {
      //   'icon': Icons.local_offer_outlined,
      //   'title': 'Practice',
      //   'route': Path.practice,
      // },
      {'icon': Icons.notifications_none, 'title': 'Notifications'},
      {'icon': Icons.help_outline, 'title': 'Help'},
      {'icon': Icons.info_outline, 'title': 'About'},
    ];
    // final currentUser = AuthNotifier().getCurrentUser();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 62.82.h,
              left: 25.w,
              right: 25.w,
              bottom: 10.66,
            ),
            child: StreamBuilder(
              stream: AuthService().userDataStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return const CircularProgressIndicator();
                }

                final userData = snapshot.data!;
                final username = userData['username'] as String? ?? '';
                final email =
                    (userData['useremail'] ?? userData['email']) as String? ??
                    '';
                final photoBase64 = userData['photoBase64'] as String?;
                final photoURL = userData['photoURL'] as String?;
                final profileImage = photoBase64 ?? photoURL ?? '';

                ImageProvider? buildProfileImageProvider(String image) {
                  if (image.isEmpty) {
                    return null;
                  } else if (image.startsWith('http')) {
                    return NetworkImage(image);
                  } else {
                    try {
                      String base64Str = image.contains(',')
                          ? image.split(',').last
                          : image;
                      return MemoryImage(base64Decode(base64Str));
                    } catch (e) {
                      return null;
                    }
                  }
                }

                return Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          buildProfileImageProvider(profileImage) ??
                          const AssetImage('assets/images/signin_bg.png'),
                      radius: 27,
                    ),
                    SizedBox(width: 20.8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          // SizedBox(height: 25.h),
          Divider(thickness: 1, color: const Color(0xffE2E2E2)),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              itemCount: accountItems.length,
              itemBuilder: (context, index) {
                final item = accountItems[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(item['icon'], color: const Color(0xff181725)),
                  title: TextWidget(
                    title: item['title'],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff181725),
                    letterSpacing: 0,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Color(0xff181725),
                  ),
                  onTap: () {
                    final route = item['route'];
                    if (route != null && route is String && route.isNotEmpty) {
                      context.go(route);
                    } else {
                      CustomSnackBar.show(context, 'Coming soon');
                    }
                  },
                );
              },
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.grey.shade300, thickness: 1, height: 0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.51),
            child: CustomButtonWidget(
              buttonName: 'Log Out',
              textColor: Colors.red,
              buttonColor: const Color(0xffF2F3F2),
              iconColor: Colors.red,
              buttonIcon: 'assets/icons/logout.svg',
              splashColor: const Color(0xffF2F3F2),
              padding: EdgeInsets.only(left: 25.17.w, right: 77.52.w),
              onPressed: state.isLoading
                  ? null
                  : () async {
                      try {
                        await ref.read(authNotifierProvider.notifier).signOut();
                        if (context.mounted) {
                          context.go(Path.login);
                        }
                        CustomSnackBar.show(context, "Log Out successful");
                      } catch (e) {
                        CustomSnackBar.show(context, "Log Out failed");
                      }
                    },
              child: state.isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
