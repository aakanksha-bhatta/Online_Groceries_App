import 'package:online_groceries_app/l10n/app_localizations.dart';

class Validation {

  static String? validEmail(AppLocalizations loc, String? value){
    if(value == null || value.trim().isEmpty){
      return "Email is Required";
    }
    return null;
  }

    static String? validPassword(AppLocalizations loc, String? value){
    if(value == null || value.trim().isEmpty){
      return "Password is Required";
    }
    return null;
  }
  
}
