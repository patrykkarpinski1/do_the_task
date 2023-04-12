import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertWidget extends StatelessWidget {
  const AlertWidget({this.onPressed, this.icon, super.key});
  final void Function()? onPressed;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
                      color: const Color.fromARGB(255, 56, 55, 55),
                    ),
                  )),
                  content: Text(
                    'Are you sure you want to delete this file ?',
                    style: GoogleFonts.arimo(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 56, 55, 55),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: onPressed,
                        child: Text(
                          'Yes',
                          style: GoogleFonts.arimo(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 56, 55, 55),
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
                            color: const Color.fromARGB(255, 56, 55, 55),
                          ),
                        ))
                  ],
                );
              });
        },
        icon: icon!);
  }
}
