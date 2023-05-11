import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/core/enums.dart';
import '/app/injection_container.dart';
import '/features/home/pages/notepad/cubit/notepad_cubit.dart';
import '/features/home/pages/notepad/pages/add_notes_page.dart';
import '/models/note_model.dart';
import '/widgets/note_widget.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class NotepadPageContent extends StatelessWidget {
  const NotepadPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotepadCubit>(
      create: (context) => getIt()..start(),
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
      appBar: NewGradientAppBar(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).focusColor,
            Theme.of(context).bottomAppBarColor,
          ],
        ),
        title: Center(
          child: Text(
            'NOTEPAD',
            style: GoogleFonts.arimo(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyText1!.color,
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
          gradient: LinearGradient(
            colors: [
              Theme.of(context).focusColor,
              Theme.of(context).bottomAppBarColor,
            ],
          ),
          borderRadius: BorderRadius.circular(55),
        ),
        child: FloatingActionButton(
          splashColor: Theme.of(context).splashColor,
          backgroundColor: Colors.transparent,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: context.read<NotepadCubit>(),
                      child: AddNotes(),
                    )));
          },
          child: Icon(
            Icons.add,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}
