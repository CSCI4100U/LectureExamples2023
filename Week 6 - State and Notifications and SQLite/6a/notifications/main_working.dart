import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationApp(),
    );
  }
}

class NotificationApp extends StatefulWidget {
  @override
  _NotificationAppState createState() => _NotificationAppState();
}

class _NotificationAppState extends State<NotificationApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  List<PendingNotificationRequest> _queuedNotifications = [];

  int _id = 0;
  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _refreshQueuedNotifications();
  }

  Future<void> _refreshQueuedNotifications() async {
    final List<PendingNotificationRequest> pendingNotifications =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    setState(() {
      _queuedNotifications = pendingNotifications;
    });
  }

  Future<void> _scheduleNotification(DateTime scheduledDate) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      icon: 'app_icon',
    );
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      _id++,
      'Scheduled Notification',
      'This is coming at ${scheduledDate.hour}:${scheduledDate.minute}:${scheduledDate.second}',
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,  // Allow the notification to be shown even when the device is in low-power idle modes.
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, // Interpret the scheduled date and time as an absolute timestamp
    );
  }

  Future<void> _deleteNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    _refreshQueuedNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification App')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _queuedNotifications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_queuedNotifications[index].title ?? 'No Title'),
                  subtitle: Text(_queuedNotifications[index].body ?? 'No Body'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteNotification(_queuedNotifications[index].id);
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              var when = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3));
              _scheduleNotification(when);
              _refreshQueuedNotifications();
            },
            child: Text('Send Notification in 3 seconds'),
          ),
          ElevatedButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedDate != null && pickedTime != null) {
                DateTime finalDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
                _scheduleNotification(finalDateTime);
                _refreshQueuedNotifications();
              }
            },
            child: Text('Pick Date & Time for Notification'),
          ),
        ],
      ),
    );
  }
}