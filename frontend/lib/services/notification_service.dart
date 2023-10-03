import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_x/screens/product/models/product.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  LocalNotification._internal();

  static final LocalNotification _instance = LocalNotification._internal();

  static LocalNotification get intance => _instance;

  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final onNotification = BehaviorSubject<String>();

  Future<void> initialize({
    void Function(String payload)? onClickNotification,
  }) async {
    initializeTimeZones();
    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    DarwinInitializationSettings iosSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    bool? initialized = await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) onNotification.add(response.payload!);
        log(response.payload.toString());
      },
    );

    onNotification.stream.listen(onClickNotification);
    log("Notifications: $initialized");
  }

  Future<List<PendingNotificationRequest>>
      pendingNotificationRequests() async =>
          await notificationsPlugin.pendingNotificationRequests();

  Future<void> cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);
    log('cancelled notification');
  }

  Future<void> scheduleExpiry({
    required Product product,
    int notifyTimeInDays = 1,
  }) async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
      "FoodX Notifications",
      "FoodX",
      priority: Priority.max,
      importance: Importance.max,
    );

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails details =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await notificationsPlugin.zonedSchedule(
      product.createdAt.millisecondsSinceEpoch ~/ 5000,
      'Food Expiration Reminder',
      'Reminder: ${product.name} is expiring today! Use it before it expires.',
      tz.TZDateTime.from(
        product.expDate.subtract(Duration(days: notifyTimeInDays)),
        tz.local,
      ),
      details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: product.id,
    );
  }
}
