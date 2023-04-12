import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modyfikacja_aplikacja/app/core/config.dart';
import 'package:modyfikacja_aplikacja/app/injection_container.dart';
import 'package:modyfikacja_aplikacja/auth/start_page/start_page.dart';

import 'cubit/auth_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => getIt()..start(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: getThemeData(),
        home: const StartPage(),
        debugShowCheckedModeBanner: Config.debugShowCheckedModeBanner,
      ),
    );
  }

  ThemeData getThemeData() {
    return ThemeData(
      primarySwatch: Colors.blue,
    );
  }
}
