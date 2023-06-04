import 'package:do_the_task/features/detalis/pages/detalis_task_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/app/core/enums.dart';
import '/app/cubit/auth_cubit.dart';
import '/auth/login/login_page.dart';
import '/features/home/home_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.errorMessage),
            ),
          );
        }
        if (state.taskId != null && state.isAppOpenedViaNotification) {
          context.read<AuthCubit>().setTaskId(state.taskId!);
          context.read<AuthCubit>().setIsAppOpenedViaNotification(false);
          Future.delayed(Duration.zero, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetalisTasksPage(id: state.taskId!)));
          });
        }
      },
      builder: (context, state) {
        final user = state.user;

        final FirebaseMessaging fcm = FirebaseMessaging.instance;
        if (state.status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (user == null) {
          return LoginPage();
        } else {
          fcm.subscribeToTopic('task_${user.uid}');
        }
        return HomePage(user: user);
      },
    );
  }
}
