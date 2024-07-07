import 'dart:convert';
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
  final List<String>? notificationStrings = prefs.getStringList('notifications');
  if (notificationStrings != null) {
    setState(() {
      notifications = notificationStrings
          .map((notificationString) => jsonDecode(notificationString) as Map<String, dynamic>)
          .toList();
    });
  }
  notifications.sort((a, b) {
      final timeA = DateTime.parse(a['time']);
      final timeB = DateTime.parse(b['time']);
      return timeB.compareTo(timeA); 
    });
}

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(title: const Text("Thông báo")),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final time = DateTime.parse(notification['time']);
          return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      notifications.removeAt(index);
                      _saveNotificationsToPrefs();
                    });
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Xóa',                  
                ),    
              ],
            ),
            child: Card(
              child: ListTile(
                title: Text(notification['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(notification['body']),
                trailing: Text(
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(time.toLocal())),
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
