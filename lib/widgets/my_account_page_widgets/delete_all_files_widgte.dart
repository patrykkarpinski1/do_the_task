import 'package:do_the_task/app/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteAllFilesWidget extends StatelessWidget {
  const DeleteAllFilesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
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
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                )),
                content: Text(
                  'Are you sure you want to delete all your files?',
                  style: GoogleFonts.arimo(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () async {
                        context.read<AuthCubit>().deleteAllFiles();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Yes',
                        style: GoogleFonts.arimo(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyText1!.color,
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
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ))
                ],
              );
            });
      },
      leading: const Icon(
        Icons.delete,
        color: Color.fromARGB(255, 56, 55, 55),
      ),
      title: Text(
        'DELETE ALL FILES',
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: const Color.fromARGB(255, 56, 55, 55),
        ),
      ),
    );
  }
}
