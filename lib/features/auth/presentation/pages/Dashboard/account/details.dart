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
import 'package:online_groceries_app/core/services/auth_service.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';

class Details extends ConsumerStatefulWidget {
  Details({super.key});

  @override
  ConsumerState<Details> createState() => _DetailsState();
}

class _DetailsState extends ConsumerState<Details> {
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController usernameController;
  late TextEditingController emailController;

  String? originalUsername;
  String? originalPhotoBase64;

  bool _isEdited = false;
  bool _isSaving = false;
  String? _newPhotoBase64;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();

    usernameController.addListener(_checkIfEdited);
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _checkIfEdited() {
    final isUsernameChanged =
        usernameController.text.trim() != (originalUsername ?? '').trim();
    final isPhotoChanged =
        _newPhotoBase64 != null && _newPhotoBase64 != originalPhotoBase64;

    final shouldEnable = isUsernameChanged || isPhotoChanged;

    if (shouldEnable != _isEdited) {
      setState(() {
        _isEdited = shouldEnable;
      });
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickAndUploadImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickAndUploadImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Remove Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _removeProfilePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickAndUploadImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final bytes = await file.readAsBytes();
      final base64Image = base64Encode(bytes);

      setState(() {
        _newPhotoBase64 = base64Image;
      });

      _checkIfEdited();
    }
  }

  Future<void> _removeProfilePhoto() async {
    setState(() {
      _newPhotoBase64 = '';
    });

    _checkIfEdited();
  }

  Future<void> _saveUserDetails() async {
    if (!_formKey.currentState!.validate()) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isSaving = true);

    try {
      final updateData = <String, dynamic>{
        'username': usernameController.text.trim(),
      };

      if (_newPhotoBase64 != null) {
        updateData['photoBase64'] = _newPhotoBase64;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update(updateData);

      // ref.invalidate(userDataProvider);

      setState(() {
        _isEdited = false;
        originalUsername = usernameController.text.trim();
        originalPhotoBase64 = _newPhotoBase64;
        _newPhotoBase64 = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.go(Path.account),
        ),
      ),
      body: StreamBuilder<Map<String, dynamic>?>(
        stream: authService.userDataStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return const Center(child: Text('Failed to load user data'));
          }

          final userData = snapshot.data!;
          final username = userData['username'] as String? ?? '';
          final email =
              (userData['useremail'] ?? userData['email']) as String? ?? '';

          final photoBase64 = userData['photoBase64'] as String?;
          final photoURL = userData['photoURL'] as String?;

          final profileImage = _newPhotoBase64 ?? photoBase64 ?? photoURL ?? '';

          if (originalUsername == null) {
            originalUsername = username;
            originalPhotoBase64 = profileImage;

            usernameController.text = username;
            emailController.text = email;
          }

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

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        Container(
                          height: 120.32.h,
                          width: 120.44.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(27.r),
                          ),
                          child: profileImage.isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: buildProfileImageProvider(
                                    profileImage,
                                  ),
                                  // MemoryImage(
                                  //   base64Decode(profileImage),
                                  // ),
                                  radius: 60,
                                )
                              : Image.asset('assets/images/signin_bg.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () => _showImageSourceActionSheet(context),
                            child: Container(
                              height: 33,
                              width: 33,
                              decoration: BoxDecoration(
                                color: const Color(0xFF53B175),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'assets/icons/pen.svg',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your name'
                          : null,
                    ),
                    const SizedBox(height: 36),
                    TextFormField(
                      readOnly: true,
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 50),
                    CustomButtonWidget(
                      buttonName: _isSaving ? 'Saving...' : 'Update',
                      isEnabled: _isEdited && !_isSaving,
                      onPressed: _isEdited && !_isSaving
                          ? _saveUserDetails
                          : null,
                      buttonColor: Colors.green,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
