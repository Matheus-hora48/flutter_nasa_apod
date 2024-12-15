import 'package:intl/intl.dart';

class DateFormatter {
  static String formatToDisplayDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  static String formatToDisplayDateTime(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(date);
  }
}
