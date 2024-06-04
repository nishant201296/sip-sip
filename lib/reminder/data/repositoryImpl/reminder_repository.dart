import 'package:sip_sip/reminder/data/data_sources/reminder_data_source.dart';
import 'package:sip_sip/reminder/domain/repository/reminder_repository.dart';

class ReminderRepository implements IReminderRepository {
  final IReminderDataSource reminderLocalDataSource;

  ReminderRepository(this.reminderLocalDataSource);

  @override
  Future<DateTime?> getLastDrankTime() async {
    try {
      final lastDrankTimeString =
          await reminderLocalDataSource.getLastDrankTime();

      final lastDrankTimeInt = int.tryParse(lastDrankTimeString!);
      return DateTime.fromMillisecondsSinceEpoch(lastDrankTimeInt!);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<int?> getNotificationDuration() async {
    try {
      final notficationDurationString =
          await reminderLocalDataSource.getNotificationDuration();

      final notficationDurationInt = int.tryParse(notficationDurationString!);
      return notficationDurationInt;
    } catch (e) {
      return -1;
    }
  }

  @override
  Future<void> setLastDrankTime() async {
    await reminderLocalDataSource
        .setLastDrankTime(DateTime.now().millisecondsSinceEpoch.toString());
  }

  @override
  Future<void> setNotificationDuration(String timeMs) async {
    await reminderLocalDataSource.setNotificationDuration(timeMs);
  }
}
