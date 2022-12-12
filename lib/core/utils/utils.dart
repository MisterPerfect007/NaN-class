import 'package:fluttertoast/fluttertoast.dart';
import 'package:nan_class/ui/colors/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../package/local_storage/keys.dart';

void showToast(String message){
  Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.mainWhite,
        textColor: AppColors.mainViolet,
        fontSize: 16.0
    );
}


///Takes time in second and return a custom formated string 'MM:SS' to be display
///
///formatTimeMMSS(69) will return "01:09"
String formatTimeMMSS(int time) {
  int min = (time >= 60) ? time ~/ 60 : 0;
  int seconds = time % 60;
  String secondsString = seconds <= 9 ? "0$seconds" : "$seconds";
  String minString = min <= 9 ? "0$min" : "$min";

  return "$minString : $secondsString";
}


Future<String?> getUserSpeciality() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(userSpecialityKEY);
}