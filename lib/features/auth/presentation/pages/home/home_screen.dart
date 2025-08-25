import 'package:flutter/material.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/chat/chat_user_list.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
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
      ),
    );
  }
}
