import 'dart:io';

import 'package:intl/intl.dart';

class DateUtil {
  static String getFormattedDate(DateTime dateTime) {
    if (Platform.localeName == "pt_BR") {
      var dateFormat = DateFormat("EEE d MMM y HH:mm", Platform.localeName);
      return dateFormat.format(dateTime);
    }
    var dateFormat = DateFormat("EEE MMM d, y h:mm a", "en_US");
    return dateFormat.format(dateTime);
  }
}
