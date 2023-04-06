import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/features/home/pages/notepad/cubit/notepad_cubit.dart';
import 'package:modyfikacja_aplikacja/features/home/pages/notepad/pages/add_notes_page.dart';
import 'package:modyfikacja_aplikacja/data/remote_data_sources/items_remote_data_source.dart';
import 'package:modyfikacja_aplikacja/models/note_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';
import 'package:modyfikacja_aplikacja/widgets/note_widget.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class NotepadPageContent extends StatelessWidget {
  const NotepadPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotepadCubit(ItemsRepository(ItemsRemoteDataSources()))..start(),
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
        },
        builder: (context, state) {
          final noteModels = state.notes;
          if (state.status == Status.initial) {
            return const Center(
              child: Text('Initial state'),
            );
          }
          if (state.status == Status.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.status == Status.success) {
            if (noteModels.isEmpty) {
              return const NotepadPage(noteModels: []);
            }
          }
          return NotepadPage(noteModels: noteModels);
        },
      ),
    );
  }
}

class NotepadPage extends StatelessWidget {
  const NotepadPage({
    Key? key,
    required this.noteModels,
  }) : super(key: key);

  final List<NoteModel> noteModels;

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
      body: GridView(
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
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.cyan, Colors.indigo],
          ),
          borderRadius: BorderRadius.circular(55),
        ),
        child: FloatingActionButton(
          splashColor: const Color.fromARGB(255, 41, 117, 199),
          backgroundColor: Colors.transparent,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: context.read<NotepadCubit>(),
                      child: AddNotes(),
                    )));
          },
          child: const Icon(
            Icons.add,
            color: Color.fromARGB(255, 56, 55, 55),
          ),
        ),
      ),
    );
  }
}
