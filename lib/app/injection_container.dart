import 'package:do_the_task/services/notifi_serivice.dart';
import 'package:do_the_task/services/notification_preference.dart';
import 'package:do_the_task/services/notification_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:do_the_task/app/injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.init();
  getIt.registerSingleton(() => NotificationPreference());
  getIt.registerSingleton(() => NotificationProvider(getIt()));
  getIt.registerSingleton(() => NotificationService(getIt()));
}
