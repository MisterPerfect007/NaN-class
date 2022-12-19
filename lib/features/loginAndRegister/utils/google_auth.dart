import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/package/local_storage/keys.dart';

Future<bool> isUserLogedIn() async {
  final prefs = await SharedPreferences.getInstance();
  if(prefs.getString(googleUserIdKEY) != null){
    // print(prefs.getString(googleUserIdKEY));
    return true;
  }
  return false;
}

Future<String?> getUserGoogleIdFromLocal() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(googleUserIdKEY);
}