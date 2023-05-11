import 'package:do_the_task/app/encryption.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/core/enums.dart';
import '/features/home/pages/notepad/cubit/notepad_cubit.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class AddNotes extends StatelessWidget {
  AddNotes({Key? key}) : super(key: key);

  final releaseDate = DateTime.now();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotepadCubit, NotepadState>(
      listener: (context, state) {
        if (state.saved) {
          context.read<NotepadCubit>().start();
          Navigator.of(context).pop();
        }
        if (state.status == Status.error) {
          final errorMessage = state.errorMessage ?? 'Unkown error';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: NewGradientAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<NotepadCubit>().start();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            actions: [
              IconButton(
                onPressed: state.textNote.isEmpty
                    ? null
                    : () {
                        final encryptedNote =
                            MyEncryptionDecription.encryptWithAESKey(
                                state.textNote);
                        context
                            .read<NotepadCubit>()
                            .add(encryptedNote, releaseDate);
                      },
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
            gradient: LinearGradient(colors: [
              Theme.of(context).focusColor,
              Theme.of(context).bottomAppBarColor,
            ]),
            title: Center(
              child: Text(
                'NOTE',
                style: GoogleFonts.arimo(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Your note",
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Theme.of(context).backgroundColor,
                ),
                maxLength: 1000,
                maxLines: 30,
                onChanged: (newTextNote) {
                  context.read<NotepadCubit>().changetextNote(newTextNote);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
