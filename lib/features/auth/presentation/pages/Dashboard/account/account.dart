import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_navigation_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class Account extends ConsumerWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, dynamic>> accountItems = [
      {'icon': Icons.shopping_bag_outlined, 'title': 'Orders'},
      {'icon': Icons.person_outline, 'title': 'My Details'},
      {'icon': Icons.location_on_outlined, 'title': 'Delivery Address'},
      {'icon': Icons.payment_outlined, 'title': 'Payment Methods'},
      {'icon': Icons.local_offer_outlined, 'title': 'Promo Codes'},
      {'icon': Icons.notifications_none, 'title': 'Notifications'},
      {'icon': Icons.help_outline, 'title': 'Help'},
      {'icon': Icons.info_outline, 'title': 'About'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Profile Section
          Padding(
            padding: EdgeInsets.only(top: 69.82.h, left: 25.w, right: 25.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 64.32.h,
                  width: 63.44.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27.r),
                  ),
                  child: Image.asset(
                    'assets/images/signin_bg.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: 'Aakanksha',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      letterSpacing: 0,
                    ),
                    TextWidget(
                      title: 'akanksha@gmail.com',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7C7C7C),
                      letterSpacing: 0,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider(thickness: 1, color: Color(0xffE2E2E2)),

          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 0),
              itemCount: accountItems.length,
              itemBuilder: (context, index) {
                final item = accountItems[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(item['icon'], color: Color(0xff181725)),
                  title: TextWidget(
                    title: item['title'],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff181725),
                    letterSpacing: 0,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Color(0xff181725),
                  ),
                  onTap: () {},
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

              buttonIcon: 'assets/icons/logout.svg',
              onPressed: () {},
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
