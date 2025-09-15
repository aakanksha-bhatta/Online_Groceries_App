import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/controller/auth_notifier.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/change_notifier.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_provider.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_navigation_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_snack_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class Account extends ConsumerWidget {
  const Account({super.key});

  Future<void> _pickAndUploadImage(WidgetRef ref, BuildContext context) async {
    final imgPicker = ImagePicker();
    final pickedFile = await imgPicker.pickImage(source: ImageSource.camera);

    if (pickedFile == null) return;

    final loadingNotifier = ref.read(loadingProvider);

    try {
      await loadingNotifier.setUploading();
      final file = File(pickedFile.path);
      final bytes = await file.readAsBytes();
      final base64Image = base64Encode(bytes);

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'photoBase64': base64Image},
      );
      ref.invalidate(userDataProvider);
    } finally {
      await loadingNotifier.setUploading();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authNotifierProvider);
    final userDataAsync = ref.watch(userDataProvider);
    final loading = ref.watch(loadingProvider);

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
      {'icon': Icons.payment_outlined, 'title': 'Payment Methods'},
      {
        'icon': Icons.local_offer_outlined,
        'title': 'Practice',
        'route': Path.practice,
      },
      {'icon': Icons.notifications_none, 'title': 'Notifications'},
      {'icon': Icons.help_outline, 'title': 'Help'},
      {'icon': Icons.info_outline, 'title': 'About'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
                  child: loading.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(strokeWidth: 1),
                        )
                      : userDataAsync.when(
                          data: (userData) {
                            final photoBase64 =
                                userData['photoBase64'] as String?;
                            if (photoBase64 != null && photoBase64.isNotEmpty) {
                              try {
                                final bytes = base64Decode(photoBase64);
                                return CircleAvatar(
                                  backgroundImage: MemoryImage(bytes),
                                );
                              } catch (_) {
                                return Image.asset(
                                  'assets/images/signin_bg.png',
                                );
                              }
                            } else {
                              return Image.asset('assets/images/signin_bg.png');
                            }
                          },
                          loading: () => const CircularProgressIndicator(),
                          error: (e, _) =>
                              Image.asset('assets/images/signin_bg.png'),
                        ),
                ),
                SizedBox(width: 15.w),
                userDataAsync.when(
                  data: (userData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextWidget(
                              title: userData['username'] ?? 'No Name',
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              letterSpacing: 0,
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () => _pickAndUploadImage(ref, context),
                              child: loading.isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : SvgPicture.asset('assets/icons/pen.svg'),
                              // child: SvgPicture.asset('assets/icons/pen.svg'),
                            ),
                          ],
                        ),
                        TextWidget(
                          title:
                              userData['useremail'] ??
                              userData['email'] ??
                              'No Email',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF7C7C7C),
                          letterSpacing: 0,
                        ),
                      ],
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (e, _) => const Text('Error loading user'),
                ),
              ],
            ),
          ),
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
              textColor: const Color(0xff53B175),
              buttonColor: const Color(0xffF2F3F2),
              buttonIcon: 'assets/icons/logout.svg',
              splashColor: const Color(0xffF2F3F2),
              padding: EdgeInsets.only(left: 25.17.w, right: 77.52.w),
              onPressed: state.isLoading
                  ? null
                  : () async {
                      try {
                        await ref.read(loadingProvider).isLoading;
                        context.go(Path.login);
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
