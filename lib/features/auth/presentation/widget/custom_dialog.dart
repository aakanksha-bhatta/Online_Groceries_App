import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final void Function()? onTap;
  const CustomDialog({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Upload Image'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Gallery'),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}


