import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_groceries_app/core/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference items = FirebaseFirestore.instance.collection(
    'items',
  );

  final TextEditingController _textController = TextEditingController();
  final auth = AuthService();

  void _showItemDialog({String? docId, String? currentText}) {
    if (currentText != null) {
      _textController.text = currentText;
    } else {
      _textController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(docId == null ? 'Add Item' : 'Edit Item'),
        content: TextField(
          controller: _textController,
          decoration: const InputDecoration(hintText: 'Enter item name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final text = _textController.text.trim();
              if (text.isEmpty) return;

              if (docId == null) {
                await items.add({'name': text});
              } else {
                await items.doc(docId).update({'name': text});
              }

              _textController.clear();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteItem(String docId) {
    items.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Firebase CRUD'),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await auth.signOut();
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: items.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['name']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showItemDialog(
                        docId: doc.id,
                        currentText: data['name'],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteItem(doc.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showItemDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
