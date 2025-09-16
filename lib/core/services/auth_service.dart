import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_snack_bar.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String verificationId = '';
  String? phoneNumber;

  Future<UserCredential?> createUserWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      return await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error logging in with email/password: $e');
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error logging in user: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print('Error signing out user: $e');
    }
  }

  Future<bool> isUserLoggedIn() async {
    return auth.currentUser != null;
  }

  User? getCurrentUser() {
    return auth.currentUser;
  }

  // for google sign in
  Future<UserCredential?> signInWithGoogle() async {
    try {
      print('Starting Google Sign-In...');

      final googleUser = await GoogleSignIn().signIn();
      print(
        "Google user: $googleUser",
      ); // DEBUG: Check if user selected an account

      if (googleUser == null) {
        print("User cancelled the Google Sign-In");
        return null;
      }

      final googleAuth = await googleUser.authentication;
      print("AccessToken: ${googleAuth.accessToken}"); // DEBUG: Access token
      print("IdToken: ${googleAuth.idToken}"); // DEBUG: ID token

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print(
        "Firebase credential created: $credential",
      ); // DEBUG: Firebase credential created

      final userCredential = await auth.signInWithCredential(credential);
      print(
        "Firebase UserCredential: $userCredential",
      ); // DEBUG: Signed in with Firebase

      return userCredential;
    } catch (e, st) {
      print('Error signing in with Google: $e');
      print('Stack trace: $st');
      return null;
    }
  }

  // for phone Number verification
  void verifyPhoneNumber({
    required String phoneNumber,
    required Function(String verificationId) codeSentCallback,
    required Function(FirebaseAuthException error) verificationFailedCallback,
  }) {
    this.phoneNumber = phoneNumber;
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: verificationFailedCallback,
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
        codeSentCallback(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Auto Retrieval Message: $verificationId');
      },
    );
  }

  Future<void> signInWithOtp({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      CustomSnackBar.show(context, 'Phone number verified successfully');
    } catch (e) {
      print('Error verifying OTP: $e');
      CustomSnackBar.show(context, 'Invalid OTP. Please try again.');
    }
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    if (!doc.exists) return null;
    return doc.data();
  }
}
