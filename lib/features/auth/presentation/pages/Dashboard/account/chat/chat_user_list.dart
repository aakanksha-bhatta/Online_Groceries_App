import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/account/chat/chat_message.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  String searchText = "";

  String getChatId(String uid1, String uid2) {
    return uid1.compareTo(uid2) < 0 ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go(Path.account);
          },
        ),
        title: TextWidget(
          title: "Message",
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(
                      color: const Color(0xff7C7C7C),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,

                      // height: 1.0,
                    ),
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value.trim();
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text("Loading users..."));
                  }

                  final allDocs = snapshot.data!.docs;

                  final docs = allDocs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final username = data['username'] ?? '';
                    return username.toLowerCase().contains(
                      searchText.toLowerCase(),
                    );
                  }).toList();

                  if (docs.isEmpty) {
                    return Center(child: Text("No users found"));
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: docs.length,
                          separatorBuilder: (context, index) =>
                              Divider(height: 0, color: Colors.grey.shade300),
                          itemBuilder: (context, index) {
                            final data =
                                docs[index].data() as Map<String, dynamic>;

                            return Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(bottom: 5),
                              child: ListTile(
                                // contentPadding: EdgeInsets.all(0),
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      (data['photoURL'] != null &&
                                          data['photoURL']
                                              .toString()
                                              .isNotEmpty)
                                      ? NetworkImage(data['photoURL'])
                                      : AssetImage(
                                              'assets/images/signin_bg.png',
                                            )
                                            as ImageProvider,
                                ),
                                title: Text(
                                  data['username'] ?? '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('chats')
                                      .doc(
                                        getChatId(
                                          FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .uid,
                                          docs[index].id,
                                        ),
                                      )
                                      .collection('messages')
                                      .orderBy('timestamp', descending: true)
                                      .limit(5)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return Text("Loading...");

                                    final currentUserId =
                                        FirebaseAuth.instance.currentUser!.uid;

                                    final filteredMessages = snapshot.data!.docs
                                        .where((doc) {
                                          final data =
                                              doc.data()
                                                  as Map<String, dynamic>;
                                          final deletedFor = List<String>.from(
                                            data['deletedFor'] ?? [],
                                          );
                                          return !deletedFor.contains(
                                            currentUserId,
                                          );
                                        })
                                        .toList();

                                    if (filteredMessages.isEmpty) {
                                      return Text(
                                        "Hey there! I am new User",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    }

                                    final messageData =
                                        filteredMessages.first.data()
                                            as Map<String, dynamic>;
                                    final isIncoming =
                                        messageData['senderId'] !=
                                        currentUserId;

                                    return Text(
                                      messageData['text'] ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: isIncoming
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    );
                                  },
                                ),

                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                        userName: data['username'],
                                        userId: docs[index].id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
