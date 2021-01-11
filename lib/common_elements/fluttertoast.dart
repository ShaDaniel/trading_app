import 'package:fluttertoast/fluttertoast.dart';
import 'colors.dart' as colors;

void showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: colors.toastBckgr,
      textColor: colors.toastText,
      fontSize: 25.0);
}
