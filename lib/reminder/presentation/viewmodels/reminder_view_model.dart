import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sip_sip/reminder/domain/models/domain_entities.dart';
import 'package:sip_sip/reminder/domain/repository/reminder_repository.dart';
import 'package:sip_sip/reminder/domain/services/notification_service.dart';
import 'package:sip_sip/reminder/domain/services/permission_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class ReminderViewModel {
  final IPermissionService _permissionService;
  final IReminderRepository _reminderRepository;
  final INotificationService _notificationService;

  ReminderViewModel(this._permissionService, this._reminderRepository,
      this._notificationService);

  final notificationPermissionResult =
      ValueNotifier<PermissionResult>(PermissionResult.na);

  final lastDrankTime = ValueNotifier<DateTime?>(null);

  final notificationDuration = ValueNotifier<int?>(null);

  Future<void> requestNotificationPermission() async {
    const Permission notificationPermission = Permission.notification;

    if (!Platform.isAndroid && !Platform.isIOS) {
      notificationPermissionResult.value = PermissionResult.na;
    } else if (await _permissionService
        .isPermissionGranted(notificationPermission)) {
      notificationPermissionResult.value = PermissionResult.granted;
    } else if (!await _permissionService.canRequest(notificationPermission)) {
      notificationPermissionResult.value = PermissionResult.showManualDialog;
    } else {
      PermissionStatus status =
          await _permissionService.requestPermission(notificationPermission);
      if (status.isGranted) {
        notificationPermissionResult.value = PermissionResult.granted;
      } else if (status.isDenied) {
        if (status.isPermanentlyDenied) {
          notificationPermissionResult.value =
              PermissionResult.showManualDialog;
        } else {
          notificationPermissionResult.value = PermissionResult.requestAgain;
        }
      } else {
        notificationPermissionResult.value = PermissionResult.na;
      }
    }
  }

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _notificationService.initNotification(initializationSettings);
  }

  void loadLastDrinkTime() async {
    final time = await _reminderRepository.getLastDrankTime();
    lastDrankTime.value = time;
  }

  void loadNotificationDuration() async {
    final time = await _reminderRepository.getNotificationDuration();
    notificationDuration.value = time;
  }

  void onDrankNowClicked() async {
    await _reminderRepository.setLastDrankTime();
    lastDrankTime.value = await _reminderRepository.getLastDrankTime();
    await _scheduleNotification();
  }

  Future<void> _scheduleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      notificationId,
      notificationChannel,
      channelDescription: notificationDescription,
      importance: Importance.max,
      priority: Priority.high,
    );
    int? duration = await _reminderRepository.getNotificationDuration();
    if (duration == null || duration == -1) {
      duration = 60;
    }

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    final scheduledDate =
        tz.TZDateTime.now(tz.local).add(Duration(seconds: duration));
    await _notificationService.notifySchdeuled(0, "Time to drink water!",
        "Remember to stay hydrated.", scheduledDate, notificationDetails);
  }

  Future<void> setNotificationDuration(String value) async {
    await _reminderRepository.setNotificationDuration(value);
  }
}
