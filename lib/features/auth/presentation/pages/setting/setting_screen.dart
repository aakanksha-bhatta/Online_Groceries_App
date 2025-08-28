import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/chat/chat_user_list.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_snack_bar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingScreenState();
  }
}

class _SettingScreenState extends State<SettingScreen> {
  String? firestoreUsername;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadFirestoreUsername();
  }

  Future<void> _loadFirestoreUsername() async {
    if (user != null && user?.displayName == null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (doc.exists) {
        setState(() {
          firestoreUsername = doc.data()?['username'] ?? 'User';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null) ...[
              CircleAvatar(
                radius: 40,
                backgroundImage: user.photoURL != null
                    ? NetworkImage(user.photoURL!)
                    : AssetImage('assets/images/signin_bg.png'),
              ),
              SizedBox(height: 10),
              Text(
                user.displayName ?? firestoreUsername ?? 'No Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              Text(
                user.email ?? '',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              Divider(height: 40),
            ],

            Center(
              child: CustomButtonWidget(
                buttonName: 'Chat',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => UserList()),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: CustomButtonWidget(
                buttonName: 'Sign out',
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  CustomSnackBar.show(context, 'Sign out Successfully');
                  context.go(Path.login);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
