abstract class IReminderDataSource {
  Future<String?> getLastDrankTime();
  Future<void> setLastDrankTime(String timeMs);
  Future<String?> getNotificationDuration();
  Future<void> setNotificationDuration(String timeMs);
}
