import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/package/local_storage/keys.dart';

Future<String?> getUserSpeciality() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(userSpecialityKEY);
}