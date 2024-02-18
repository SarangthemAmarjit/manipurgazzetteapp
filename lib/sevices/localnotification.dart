import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:open_file_plus/open_file_plus.dart';

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
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {

       
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
   log('Notification check 2dsdsd');

          // Check if the file exists
          File file = File(notificationResponse.payload!);
          if (await file.exists()) {
            // Open the file
            OpenFile.open(notificationResponse.payload);
          } else {
            print('File not found at ${notificationResponse.payload}');
          }

          break;
        case NotificationResponseType.selectedNotificationAction:
    
      

          // Check if the file exists
     
          break;
      }
  
    });
  }

  calcelnotification() async {
    await notificationsPlugin.cancelAll();
  }

  notificationDetails({required String channelid}) {
    return  NotificationDetails(
        android: AndroidNotificationDetails(
            channelid, 'Downloads',
            importance: Importance.max,
            priority: Priority.high,
            showProgress: false,
            autoCancel: true,
            playSound: true,
            enableVibration: true,
            category: AndroidNotificationCategory.status,
    
            icon: '@mipmap/ic_launcher',
            largeIcon: DrawableResourceAndroidBitmap('flutter_logo')));
  }

  Future showDownloadNotification({required String payLoad}) async {

    var splitlist = payLoad.split('/');
    return notificationsPlugin.show(
      0,
       '${splitlist.last}',
      'Download Completed✅',
     
      notificationDetails(channelid: splitlist.last),
      payload: payLoad,
    );
  }
}
