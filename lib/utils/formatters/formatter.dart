import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gmt/gmt.dart';
import 'package:intl/intl.dart';

class AppFormatter {
  
  static String formatDate(DateTime? date) {
    return DateFormat('dd/MM/yyyy').format(date ?? DateTime.now());
  }

  static String formatDateToWeekDay(DateTime? date) {
    // date ??= DateTime.now();
    return DateFormat(DateFormat.WEEKDAY).format(date ?? DateTime.now());
  }

  static Timestamp formatToTimeStamp(DateTime? date) {
    return Timestamp.fromDate(date ?? DateTime.now());
  }

  static int numberOfWeek(DateTime date, DateTime dateNow) {
    return (dateNow.difference(date).inDays / 7).ceil() + 1;
  }

  // static TimeOfDay formatStringToTime
}
