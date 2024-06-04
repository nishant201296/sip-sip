import 'package:get_it/get_it.dart';
import 'package:sip_sip/reminder/data/data_sources/reminder_data_source.dart';
import 'package:sip_sip/reminder/data/data_sources/reminder_local_data_source.dart';
import 'package:sip_sip/reminder/data/repositoryImpl/reminder_repository.dart';
import 'package:sip_sip/reminder/domain/repository/reminder_repository.dart';
import 'package:sip_sip/reminder/domain/services/notification_service.dart';
import 'package:sip_sip/reminder/domain/services/permission_service.dart';
import 'package:sip_sip/reminder/presentation/viewmodels/reminder_view_model.dart';

class DependencyInjection {
  static final GetIt _getIt = GetIt.instance;

  static void configure() {
    _getIt.registerSingleton<IPermissionService>(PermissionService());
    _getIt.registerSingleton<INotificationService>(NotificationService());
    _getIt.registerSingleton<IReminderDataSource>(ReminderDataSource());
    _getIt.registerSingleton<IReminderRepository>(
        ReminderRepository(_getIt.get<IReminderDataSource>()));
    _getIt.registerFactory<ReminderViewModel>(() => ReminderViewModel(
        _getIt.get<IPermissionService>(),
        _getIt.get<IReminderRepository>(),
        _getIt.get<INotificationService>()));
  }
}
