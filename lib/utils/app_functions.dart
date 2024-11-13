import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
export 'app_functions_non_web.dart'
    if (dart.library.html) 'app_functions_web.dart';

class AppFunctions {
  static void closeKeyBoard(BuildContext context) {
    return FocusScope.of(context).unfocus();
  }

  static String getStringFromDateTime(DateTime date, {String? formate}) {
    return DateFormat(formate ?? 'd MMM yyyy').format(date);
  }

  static DateTime parseDate(String dateString, {String format = 'd MMM yyyy'}) {
    return DateFormat(format)
        .parse(dateString); // Parse string back to DateTime
  }

  // static void popScreen(BuildContext context) {
  //   if(kIsWeb) {

  //     html.window.history.back() ;}else{

  //    Navigator.pop(context);}
  // }
}
