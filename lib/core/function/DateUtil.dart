import 'package:intl/intl.dart';

class DateUtil {
  static String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }
}