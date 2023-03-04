import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/notepad/pages/add_notes_page/add_notes_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/notepad/pages/notepad_page/cubit/notepad_cubit.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';
import 'package:modyfikacja_aplikacja/widgets/note_widget.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class NotepadPageContent extends StatelessWidget {
  const NotepadPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 225, 234),
      appBar: NewGradientAppBar(
        gradient: const LinearGradient(
          colors: [Colors.cyan, Colors.indigo],
        ),
        title: Center(
          child: Text(
            'NOTEPAD',
            style: GoogleFonts.arimo(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 56, 55, 55),
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => NotepadCubit(ItemsRepository())..start(),
        child: BlocConsumer<NotepadCubit, NotepadState>(
            listener: (context, state) {
          if (state.status == Status.error) {
            final errorMessage = state.errorMessage ?? 'Unkown error';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        }, builder: (context, state) {
          final noteModels = state.notes;
          if (state.status == Status.initial) {
            return const Center(
              child: Text('Initial state'),
            );
          }
          if (state.status == Status.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == Status.success) {
            if (noteModels.isEmpty) {
              return const SizedBox.shrink();
            }
          }

          return GridView(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            children: [
              for (final noteModel in noteModels) ...[
                NoteWidget(
                  noteModel: noteModel,
                ),
              ]
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: const Color.fromARGB(255, 41, 117, 199),
        backgroundColor: const Color.fromARGB(255, 122, 166, 192),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddNotes(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 56, 55, 55),
        ),
      ),
    );
  }
}
