
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nan_class/ui/colors/app_colors.dart';

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