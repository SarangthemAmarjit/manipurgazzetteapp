import 'dart:async';
import 'dart:developer';



import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';



class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();





  Future<void> initNotification() async {
    notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(
      initializationSettings, 
            onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            log('Notification check 1');
        if (notificationResponse.payload != null) OpenFile.open(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
    log('Notification check 2');
      break;
  }
          
        });
      }
      
    

  calcelnotification() async {
    await notificationsPlugin.cancelAll();
  }


  notificationDetails() {
    return const NotificationDetails(
        android:           AndroidNotificationDetails('download_notification', 'Downloads',
              importance: Importance.max,
              priority: Priority.high,
              showProgress: false,
              autoCancel: false,
              playSound: true,
              enableVibration: true,
              styleInformation: BigTextStyleInformation(''),
              icon: '@mipmap/ic_launcher',
              largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher')));
  }



  Future showDownloadNotification(
      { required String payLoad}) async {
    return notificationsPlugin.show(
        0,
        'Download Completed',
        'File downloaded successfully',
        notificationDetails(),
        payload: payLoad,
      );
  }
}
