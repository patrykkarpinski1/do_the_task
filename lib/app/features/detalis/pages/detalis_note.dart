import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/features/detalis/cubit/detalis_cubit.dart';
import 'package:modyfikacja_aplikacja/models/note_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class DetalisNotePage extends StatelessWidget {
  const DetalisNotePage({required this.id, this.noteModel, super.key});
  final String id;
  final NoteModel? noteModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetalisCubit(ItemsRepository())..getNoteWithID(id),
      child: BlocConsumer<DetalisCubit, DetalisState>(
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
            if (state.noteModel == null) {
              return const SizedBox.shrink();
            }
          }
          final noteModel = state.noteModel;
          return Scaffold(
            appBar: NewGradientAppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 56, 55, 55),
                ),
              ),
              actions: [
                PopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Color.fromARGB(255, 56, 55, 55),
                    ),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text(
                            "Delete note ",
                            style: GoogleFonts.arimo(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 56, 55, 55),
                            ),
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text(
                            "Edit note ",
                            style: GoogleFonts.arimo(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 56, 55, 55),
                            ),
                          ),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 0) {}
                      if (value == 1) {}
                    }),
              ],
              gradient:
                  const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
              title: Center(
                child: Text(
                  noteModel!.noteDate(),
                  style: GoogleFonts.arimo(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 56, 55, 55),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListView(children: [
                Text(
                  noteModel.note,
                  style: GoogleFonts.arimo(
                    fontSize: 16,
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
