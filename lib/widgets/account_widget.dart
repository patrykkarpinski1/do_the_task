import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/cubit/auth_cubit.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  bool fav = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 65,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.cyan, Colors.indigo],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                bottomLeft: Radius.circular(45),
              ),
            ),
            child: TextButton(
              onPressed: () {
                context.read<AuthCubit>().deleteAccount();
                Navigator.of(context).pop();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Center(
                  child: Text(
                    'Delete Account',
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
          if (widget.user.emailVerified == false) ...[
            Container(
              height: 65,
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: TextButton(
                onPressed: () {
                  if (fav) {
                    setState(() => fav = false);
                  } else {
                    context.read<AuthCubit>().resendEmailVerification();
                    setState(() => fav = true);
                  }
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Center(
                    child: Text(
                      fav ? 'Unverified account' : 'Resend Email Verification',
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
          if (widget.user.emailVerified == true) ...[
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
          Container(
            height: 65,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.cyan, Colors.indigo],
              ),
              borderRadius: BorderRadius.only(
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
                      color: const Color.fromARGB(255, 56, 55, 55),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
