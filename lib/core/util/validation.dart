import 'package:flutter_intl_phone_field/phone_number.dart';
import 'package:online_groceries_app/l10n/app_localizations.dart';

class Validation {
  static String? validEmail(AppLocalizations loc, String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid Email Format';
    }
    return null;
  }

  static String? validPassword(AppLocalizations loc, String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  static String? validUsername(AppLocalizations loc, String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is Required";
    }
    if (value.trim().length < 3) {
      return "Username must be at least 3 characters long";
    }
    if (value.trim().length > 20) {
      return "Username must be less than 20 characters";
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return "Username can only contain letters, numbers, and underscores";
    }
    return null;
  }

  static String? validPhoneNumber(AppLocalizations loc, PhoneNumber? phone) {
    if (phone == null || phone.completeNumber.trim().isEmpty) {
      return "Phone number is Required";
    }
    if (phone.completeNumber.trim().length < 10) {
      return "Phone number must be at least 10 characters long";
    }
    if (!RegExp(r'^[0-9]').hasMatch(phone.completeNumber)) {
      return "Phone number can only contain numbers";
    }
    return null;
  }

  static String? validOtp(AppLocalizations loc, String? value) {
    if (value == null || value.trim().isEmpty) {
      return "OTP is Required";
    }
    if (value.trim().length < 4) {
      return "OTP must be at least 4 characters long";
    }
    return null;
  }
}
