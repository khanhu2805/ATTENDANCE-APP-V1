import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AppFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatDateToWeekDay(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat(DateFormat.WEEKDAY).format(date);
  }

  static Timestamp formatToTimeStamp() {
    return Timestamp.fromDate(DateTime.now());
  }

  static int numberOfWeek(DateTime date) {
    return (DateTime.now().difference(date).inDays / 7).ceil() + 1;
  }
}
