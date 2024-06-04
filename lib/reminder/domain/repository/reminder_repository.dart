abstract class IReminderRepository {
  Future<DateTime?> getLastDrankTime();
  Future<void> setLastDrankTime();
  Future<int?> getNotificationDuration();
  Future<void> setNotificationDuration(String timeMs);
}
