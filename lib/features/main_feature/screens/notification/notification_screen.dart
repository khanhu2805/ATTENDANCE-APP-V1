import 'dart:convert';
import 'package:fe_attendance_app/utils/constants/sizes.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static const route = '/notification_screen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? notificationStrings =
        prefs.getStringList('notifications');
    if (notificationStrings != null) {
      setState(() {
        notifications = notificationStrings
            .map((notificationString) =>
                jsonDecode(notificationString) as Map<String, dynamic>)
            .toList();
      });
    }
    notifications.sort((a, b) {
      final timeA = DateTime.parse(a['time']);
      final timeB = DateTime.parse(b['time']);
      return timeB.compareTo(timeA);
    });
  }

  String formatTimeDifference(DateTime notificationTime) {
    final now = DateTime.now();
    final difference = now.difference(notificationTime);
    final minutes = difference.inMinutes;

    if (minutes < 1) {
      return "Vừa mới";
    } else if (minutes < 60) {
      return "$minutes phút trước";
    } else if (minutes < 1440) {
      return "${difference.inHours} giờ trước";
    } else {
      return DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(notificationTime.toLocal());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Thông báo',
          style: TextStyle(
            fontSize: AppSizes.fontSizeXl,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final time = DateTime.parse(notification['time']);
          return Slidable(
            endActionPane: ActionPane(
              extentRatio: 0.25,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      notifications.removeAt(index);
                      _saveNotificationsToPrefs();
                    });
                  },
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.red,
                  icon: Icons.delete,
                  label: 'Xóa',
                  borderRadius: BorderRadius.circular(10.0),
                  flex: 1,
                ),
              ],
            ),
            child: Card(
              elevation: 3.0,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Colors.white,
              child: ListTile(
                title: Text(notification['title'],
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: THelperFunctions.screenWidth() * 0.04)),
                subtitle: Text(
                  notification['body'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: THelperFunctions.screenWidth() * 0.04),
                ),
                trailing: Text(
                  formatTimeDifference(time.toLocal()),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: THelperFunctions.screenWidth() * 0.04),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveNotificationsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'notifications',
      notifications.map((e) => jsonEncode(e)).toList(),
    );
  }
}
