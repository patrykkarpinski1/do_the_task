import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/core/enums.dart';
import '/features/home/pages/notepad/cubit/notepad_cubit.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class AddNotes extends StatelessWidget {
  AddNotes({
    super.key,
  });

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
          backgroundColor: const Color.fromARGB(255, 208, 225, 234),
          appBar: NewGradientAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<NotepadCubit>().start();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 56, 55, 55),
              ),
            ),
            actions: [
              IconButton(
                onPressed: state.textNote.isEmpty
                    ? null
                    : () {
                        context
                            .read<NotepadCubit>()
                            .add(state.textNote, releaseDate);
                      },
                icon: const Icon(
                  Icons.check,
                  color: Color.fromARGB(255, 56, 55, 55),
                ),
              ),
            ],
            gradient:
                const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
            title: Center(
              child: Text(
                'NOTE',
                style: GoogleFonts.arimo(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 56, 55, 55),
                ),
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Your note",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
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
