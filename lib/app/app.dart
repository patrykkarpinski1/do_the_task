import 'package:do_the_task/app/core/styles.dart';
import 'package:do_the_task/app/dark_theme/dark_theme_provider.dart';
import 'package:do_the_task/services/notification_preference.dart';
import 'package:do_the_task/services/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '/app/core/config.dart';
import '/app/injection_container.dart';
import '/auth/start_page/start_page.dart';

import 'cubit/auth_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final notificationPreference = NotificationPreference();
    final notificationProvider = NotificationProvider(notificationPreference);

    return BlocProvider<AuthCubit>(
      create: (context) => getIt()..start(),
      child: ChangeNotifierProvider<DarkThemeProvider>(
        create: (_) => DarkThemeProvider(),
        child: Consumer<DarkThemeProvider>(
          builder: (context, darkThemeProvider, _) {
            return ChangeNotifierProvider<NotificationProvider>.value(
              value: notificationProvider,
              child: GetMaterialApp(
                title: 'Do the task',
                theme: darkThemeProvider.darkTheme
                    ? Styles.getDarkMode()
                    : Styles.getThemeData(),
                home: const StartPage(),
                debugShowCheckedModeBanner: Config.debugShowCheckedModeBanner,
              ),
            );
          },
        ),
      ),
    );
  }
}
