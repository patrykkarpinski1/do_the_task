import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/notepad/pages/add_notes_page/cubit/add_note_cubit.dart';

class AddNotes extends StatelessWidget {
  const AddNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit()..start(),
      child: BlocListener<AddNoteCubit, AddNoteState>(
        listener: (context, state) {
          if (state.saved) {
            Navigator.of(context).pop();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        child: BlocBuilder<AddNoteCubit, AddNoteState>(
          builder: (context, state) {
            return StreamBuilder<Object>(builder: (context, snapshot) {
              return Scaffold(
                backgroundColor: const Color.fromARGB(255, 49, 171, 175),
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 247, 143, 15),
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: state.textNote.isEmpty
                          ? null
                          : () {
                              context.read<AddNoteCubit>().add(state.textNote);
                            },
                      icon: const Icon(
                        Icons.check,
                        color: Color.fromARGB(255, 247, 143, 15),
                      ),
                    ),
                  ],
                  backgroundColor: const Color.fromARGB(255, 1, 100, 146),
                  title: Text(
                    'NOTE',
                    style: GoogleFonts.rubikBeastly(
                      color: const Color.fromARGB(255, 247, 143, 15),
                    ),
                  ),
                ),
                body: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                          hintText: "Your note",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color.fromARGB(255, 133, 220, 223)),
                      maxLength: 10000,
                      maxLines: 30,
                      onChanged: (newTextNote) {
                        context
                            .read<AddNoteCubit>()
                            .changetextNote(newTextNote);
                      },
                    ),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
