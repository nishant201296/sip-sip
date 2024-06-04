import 'package:shared_preferences/shared_preferences.dart';
import 'package:sip_sip/reminder/data/data_sources/reminder_data_source.dart';

class ReminderDataSource implements IReminderDataSource {
  final _lastDrankKey = "lastDrankTime";
  final _notificationDurationKey = "reminderInterval";

  @override
  Future<String?> getLastDrankTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastDrankKey);
  }

  @override
  Future<String?> getNotificationDuration() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_notificationDurationKey);
  }

  @override
  Future<void> setLastDrankTime(String timeMs) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_lastDrankKey, timeMs);
  }

  @override
  Future<void> setNotificationDuration(String timeMs) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_notificationDurationKey, timeMs);
  }
}
