import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/cubit/auth_cubit.dart';

class AccountActionsWidget extends StatefulWidget {
  const AccountActionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountActionsWidget> createState() => _AccountActionsWidgetState();
}

class _AccountActionsWidgetState extends State<AccountActionsWidget> {
  bool fav = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Container(
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(45),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 65,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).focusColor,
                      Theme.of(context).bottomAppBarColor,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(45),
                    bottomLeft: Radius.circular(45),
                  ),
                ),
                child: TextButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Center(
                                child: Text(
                              'ATTENTION',
                              style: GoogleFonts.arimo(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            )),
                            content: Text(
                              'Are you sure you want to delete this account ?',
                              style: GoogleFonts.arimo(
                                fontSize: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    context.read<AuthCubit>().deleteAccount();
                                    context
                                        .read<AuthCubit>()
                                        .deleteAccountData();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Yes',
                                    style: GoogleFonts.arimo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                    ),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'No',
                                    style: GoogleFonts.arimo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                    ),
                                  ))
                            ],
                          );
                        });
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Center(
                      child: Text(
                        'Delete Account',
                        style: GoogleFonts.arimo(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (state.user?.emailVerified == true) ...[
                Container(
                  height: 65,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Center(
                        child: Text(
                          'Verified account',
                          style: GoogleFonts.arimo(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 56, 55, 55),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              if (state.user?.emailVerified == false) ...[
                Container(
                  height: 65,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (fav) {
                        context.read<AuthCubit>().userReloded();
                        setState(() => fav = false);
                      } else {
                        context.read<AuthCubit>().resendEmailVerification();
                        context.read<AuthCubit>().userReloded();
                        setState(() => fav = true);
                      }
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Center(
                        child: Text(
                          fav
                              ? 'Unverified account'
                              : 'Resend Email Verification',
                          style: GoogleFonts.arimo(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 56, 55, 55),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              Container(
                height: 65,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).focusColor,
                      Theme.of(context).bottomAppBarColor,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(45),
                    bottomRight: Radius.circular(45),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                    context.read<AuthCubit>().start();
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Center(
                      child: Text(
                        'Sign out',
                        style: GoogleFonts.arimo(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
