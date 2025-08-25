import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/chat/chat_message.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Align(
            alignment: Alignment.center,
            child: TextWidget(
              title: "Message",
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12),

                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value.toLowerCase().trim();
                    });
                  },
                ),
              ),

              // Expanded(
              //   child: StreamBuilder<QuerySnapshot>(
              //     stream: FirebaseFirestore.instance
              //         .collection('users')
              //         .doc(FirebaseAuth.instance.currentUser!.uid)
              //         .collection('chats')
              //         .orderBy('timestamp', descending: true)
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (!snapshot.hasData) {
              //         return Center(child: CircularProgressIndicator());
              //       }

              //       final docs = snapshot.data!.docs;

              //       return ListView.builder(
              //         reverse: true,
              //         itemCount: docs.length,
              //         itemBuilder: (context, index) {
              //           final data = docs[index].data() as Map<String, dynamic>;
              //           return Align(
              //             alignment: Alignment.centerRight,
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(vertical: 4),
              //               child: Text(data['text'] ?? ''),
              //             ),
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: (searchText.isEmpty)
                      ? FirebaseFirestore.instance
                            .collection('users')
                            .snapshots()
                      : FirebaseFirestore.instance
                            .collection('users')
                            .where(
                              'username',
                              isGreaterThanOrEqualTo: searchText,
                            )
                            .where(
                              'username',
                              isLessThanOrEqualTo: searchText + '\uf8ff',
                            )
                            .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: Text("Search Users"));

                    final docs = snapshot.data!.docs;

                    if (docs.isEmpty)
                      return Center(child: Text("No users found"));

                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index].data() as Map<String, dynamic>;
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(
                              'assets/images/signin_bg.png',
                            ),
                          ),
                          title: Text(data['username'] ?? ''),
                          subtitle: Text(data['useremail'] ?? ''),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChatScreen(userName: data['username']),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
