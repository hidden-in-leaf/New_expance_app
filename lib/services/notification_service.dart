import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tzdata.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(initSettings);
  }

  static Future<void> scheduleReminder({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required String repeatType, // "once", "daily", "monthly", "quarterly", "yearly", "custom"
    int? timesPerDay, // For daily
    int? repeatForDays, // For daily
    int? customMonths, // For custom repeat
  }) async {
    final tzDate = tz.TZDateTime.from(scheduledDate, tz.local);

    if (repeatType == 'once') {
      await _notifications.zonedSchedule(
        id,
        title,
        body,
        tzDate,
        NotificationDetails(
          android: AndroidNotificationDetails('reminder_channel', 'Reminders', importance: Importance.max),
          iOS: DarwinNotificationDetails(),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } else if (repeatType == 'daily' && timesPerDay != null && repeatForDays != null) {
      for (int day = 0; day < repeatForDays; day++) {
        for (int t = 0; t < timesPerDay; t++) {
          final scheduled = tzDate.add(Duration(days: day, hours: t * (24 ~/ timesPerDay)));
          await _notifications.zonedSchedule(
            id + day * timesPerDay + t,
            title,
            body,
            scheduled,
            NotificationDetails(
              android: AndroidNotificationDetails('reminder_channel', 'Reminders', importance: Importance.max),
              iOS: DarwinNotificationDetails(),
            ),
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
          );
        }
      }
    } else if (repeatType == 'monthly' || repeatType == 'yearly') {
      await _notifications.zonedSchedule(
        id,
        title,
        body,
        tzDate,
        NotificationDetails(
          android: AndroidNotificationDetails('reminder_channel', 'Reminders', importance: Importance.max),
          iOS: DarwinNotificationDetails(),
        ),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: repeatType == 'monthly'
            ? DateTimeComponents.dayOfMonthAndTime
            : DateTimeComponents.dateAndTime,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } else if (repeatType == 'custom' && customMonths != null) {
      for (int i = 0; i < 12; i += customMonths) {
        final customDate = tz.TZDateTime(tz.local, scheduledDate.year, scheduledDate.month + i, scheduledDate.day, scheduledDate.hour, scheduledDate.minute);
        await _notifications.zonedSchedule(
          id + i,
          title,
          body,
          customDate,
          NotificationDetails(
            android: AndroidNotificationDetails('reminder_channel', 'Reminders', importance: Importance.max),
            iOS: DarwinNotificationDetails(),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
    }
  }

  static Future<void> cancel(int id) async {
    await _notifications.cancel(id);
  }

  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }
}