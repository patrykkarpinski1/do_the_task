import 'package:do_the_task/app/cubit/auth_cubit.dart';
import 'package:do_the_task/services/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotifiactionsEnabledWidget extends StatefulWidget {
  const NotifiactionsEnabledWidget({
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  State<NotifiactionsEnabledWidget> createState() =>
      _NotifiactionsEnabledWidgetState();
}

class _NotifiactionsEnabledWidgetState
    extends State<NotifiactionsEnabledWidget> {
  late bool onTapValue;
  late NotificationProvider notificationProvider;

  @override
  void initState() {
    super.initState();
    onTapValue = widget.value;
    notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    if (onTapValue) {
      notificationProvider.enableNotifications();
    } else {
      notificationProvider.disableNotifications();
    }
  }

  @override
  void didUpdateWidget(NotifiactionsEnabledWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      onTapValue = widget.value;
      if (onTapValue) {
        context.read<AuthCubit>().enableNotifications();
      } else {
        context.read<AuthCubit>().disableNotifications();
      }
    }
  }

  void onTapValueChanged(bool? value) {
    setState(() {
      onTapValue = value ?? true;
    });
    if (onTapValue) {
      notificationProvider.enableNotifications();
      context.read<AuthCubit>().enableNotifications();
    } else {
      notificationProvider.disableNotifications();
      context.read<AuthCubit>().disableNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 7),
          child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.trailing,
            contentPadding: EdgeInsets.zero,
            title: Text(
              'NOTIFICATIONS ENABLED',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: const Color.fromARGB(255, 56, 55, 55),
              ),
            ),
            value: onTapValue,
            onChanged: onTapValueChanged,
          ),
        );
      },
    );
  }
}
