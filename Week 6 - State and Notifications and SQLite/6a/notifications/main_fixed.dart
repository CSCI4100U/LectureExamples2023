import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

void main() async {
  tzdata.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');
  // final IOSInitializationSettings initializationSettingsIOS =
  // IOSInitializationSettings();
  final InitializationSettings initializationSettings =
  InitializationSettings(
    android: initializationSettingsAndroid,
//      iOS: initializationSettingsIOS
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MaterialApp(
    home: MyApp()
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Initialize notifications
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    // final IOSInitializationSettings initializationSettingsIOS =
    // IOSInitializationSettings();
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
//        iOS: initializationSettingsIOS
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Function to show a Snackbar
  void _showSnackbar(BuildContext context, String scheduledTime) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Notification scheduled for $scheduledTime'),
    ));
  }

  // Function to schedule a notification
  Future<void> _scheduleNotification(BuildContext context, DateTime scheduledTime) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    // const IOSNotificationDetails iOSPlatformChannelSpecifics =
    // IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      //    iOS: iOSPlatformChannelSpecifics,
    );

    final timeZone = tz.local;

    final scheduledNotificationDateTime =
    tz.TZDateTime.from(scheduledTime, timeZone);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Scheduled Notification',
      'This is a scheduled notification.',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );

    _showSnackbar(context, 'Notification scheduled for $scheduledTime');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Notification App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  // Show an immediate notification
                  await flutterLocalNotificationsPlugin.show(
                    0,
                    'Immediate Notification',
                    'This is an immediate notification.',
                    NotificationDetails(
                      android: AndroidNotificationDetails(
                        'your_channel_id',
                        'your_channel_name',
                        channelDescription: 'your_channel_description',
                        importance: Importance.max,
                        priority: Priority.high,
                      ),
                      //iOS: IOSNotificationDetails(),
                    ),
                  );
                  _showSnackbar(context, 'Immediate notification displayed');
                },
                child: Text('Show Immediate Notification'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Show a date/time picker for scheduling
                  final selectedTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (selectedTime != null && pickedTime != null) {
                    final selectedDateTime = DateTime(
                      selectedTime.year,
                      selectedTime.month,
                      selectedTime.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                    await _scheduleNotification(context, selectedDateTime);
                  }
                },
                child: Text('Schedule Notification'),
              ),
            ],
          ),
        ),
    );
  }
}
