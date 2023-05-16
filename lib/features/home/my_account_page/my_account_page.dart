import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/core/enums.dart';
import '/app/cubit/auth_cubit.dart';
import '../../../widgets/my_account_page_widgets/account_actions_widget.dart';
import '../../../widgets/my_account_page_widgets/user_info_widget.dart';
import '../../../widgets/my_account_page_widgets/user_photo_widget.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({
    required this.user,
    Key? key,
  }) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == Status.error) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.errorMessage),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: NewGradientAppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).iconTheme.color,
                )),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).focusColor,
                Theme.of(context).bottomAppBarColor,
              ],
            ),
            title: Text(
              'ACCOUNT',
              style: GoogleFonts.arimo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(15.0),
            children: [
              const UserPhotoWidget(),
              const SizedBox(
                height: 30,
              ),
              const AccountActionsWidget(),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 60,
                        width: 50,
                        child: Divider(
                          thickness: 1,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        )),
                    Text(
                      '   Account Info   ',
                      style: GoogleFonts.arimo(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 50,
                      child: Divider(
                        thickness: 1,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                  ],
                ),
              ),
              UserInfoWidget(user: user)
            ],
          ),
        );
      },
    );
  }
}
