import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/auth/pages/user_profile.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/notepad/cubit/notepad_cubit.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/notepad/pages/add_notes_page/add_notes_page.dart';

class NotepadPageContent extends StatelessWidget {
  const NotepadPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 171, 175),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const UserProfile(),
                ),
              );
            },
            icon: const Icon(
              Icons.person,
              color: Color.fromARGB(255, 247, 143, 15),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 1, 100, 146),
        title: Text(
          'NOTEPAD',
          style: GoogleFonts.rubikBeastly(
            color: const Color.fromARGB(255, 247, 143, 15),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => NotepadCubit()..start(),
        child: BlocBuilder<NotepadCubit, NotepadState>(
          builder: (context, state) {
            final docs = state.notes?.docs;
            if (docs == null) {
              return const SizedBox.shrink();
            }
            return GridView(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              children: [
                for (final doc in docs) ...[
                  Dismissible(
                    key: ValueKey(doc.id),
                    onDismissed: (direction) {
                      context.read<NotepadCubit>().remove(documentID: doc.id);
                    },
                    child: _NoteWidget(
                      document: doc,
                    ),
                  ),
                ]
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 1, 100, 146),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddNotes(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 247, 143, 15),
        ),
      ),
    );
  }
}

class _NoteWidget extends StatelessWidget {
  const _NoteWidget({
    Key? key,
    required this.document,
  }) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> document;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 133, 220, 223),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Text(
          document['title'],
        ),
      ),
    );
  }
}
