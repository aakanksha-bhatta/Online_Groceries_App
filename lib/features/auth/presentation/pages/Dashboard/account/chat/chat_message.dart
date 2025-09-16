import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  late String userName;
  late String userId;
  late String photo;

  ChatScreen({
    super.key,
    required this.userName,
    required this.userId,
    required this.photo,
  });

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  late String chatId;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final myUid = FirebaseAuth.instance.currentUser!.uid;
    chatId = getChatId(myUid, widget.userId);
  }

  String getChatId(String uid1, String uid2) {
    return uid1.compareTo(uid2) < 0 ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final userId = currentUser.uid;
    final receiverUsername = widget.userName;

    final localTimestamp = DateTime.now();

    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
            'text': text,
            'timestamp': FieldValue.serverTimestamp(),
            'createdAt': localTimestamp,
            'senderId': userId,
            'receiverUsername': receiverUsername,
          });
    } catch (e) {
      print('Failed to send message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.userName, style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final allMessages = snapshot.data!.docs;

                final messages = allMessages.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final deletedFor = List<String>.from(
                    data['deletedFor'] ?? [],
                  );
                  return !deletedFor.contains(currentUserId);
                }).toList();
                if (messages.isEmpty) {
                  return Center(
                    child: Text(
                      'Hey there!, I am new User',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final doc = messages[index];
                    final data = doc.data() as Map<String, dynamic>;
                    final isMe = data['senderId'] == currentUserId;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: isMe
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isMe)
                              CircleAvatar(
                                radius: 18,
                                backgroundImage: (widget.photo.isNotEmpty)
                                    ? MemoryImage(base64Decode(widget.photo))
                                    : AssetImage('assets/images/signin_bg.png')
                                          as ImageProvider,
                              ),

                            SizedBox(width: 8),
                            Flexible(
                              child: GestureDetector(
                                onLongPress: () async {
                                  List<Widget> options = [];
                                  if (isMe) {
                                    options.addAll([
                                      ListTile(
                                        leading: Icon(
                                          Icons.delete_forever,
                                          color: Colors.grey,
                                        ),
                                        title: Text('Delete for Everyone'),
                                        onTap: () => Navigator.of(
                                          context,
                                        ).pop('everyone'),
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.delete,
                                          color: Colors.grey,
                                        ),
                                        title: Text('Delete for Me'),
                                        onTap: () =>
                                            Navigator.of(context).pop('me'),
                                      ),
                                    ]);
                                  } else {
                                    options.add(
                                      ListTile(
                                        leading: Icon(
                                          Icons.delete,
                                          color: Colors.grey,
                                        ),
                                        title: Text('Delete'),
                                        onTap: () =>
                                            Navigator.of(context).pop('me'),
                                      ),
                                    );
                                  }

                                  options.add(
                                    ListTile(
                                      leading: Icon(Icons.close),
                                      title: Text('Cancel'),
                                      onTap: () =>
                                          Navigator.of(context).pop(null),
                                    ),
                                  );

                                  final selectedOption =
                                      await showModalBottomSheet<String>(
                                        context: context,
                                        builder: (context) => SafeArea(
                                          child: Wrap(children: options),
                                        ),
                                      );

                                  if (selectedOption == 'everyone') {
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection('chats')
                                          .doc(chatId)
                                          .collection('messages')
                                          .doc(doc.id)
                                          .delete();
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Failed to delete message for everyone: $e',
                                          ),
                                        ),
                                      );
                                    }
                                  } else if (selectedOption == 'me') {
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection('chats')
                                          .doc(chatId)
                                          .collection('messages')
                                          .doc(doc.id)
                                          .update({
                                            'deletedFor': FieldValue.arrayUnion(
                                              [currentUserId],
                                            ),
                                          });
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Failed to delete message for me: $e',
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isMe
                                        ? Colors.green[100]
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(data['text'] ?? ''),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Divider(color: Colors.grey, thickness: 1),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
