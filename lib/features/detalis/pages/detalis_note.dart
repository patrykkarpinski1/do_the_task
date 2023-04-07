import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/injection_container.dart';
import 'package:modyfikacja_aplikacja/features/detalis/cubit/detalis_cubit.dart';
import 'package:modyfikacja_aplikacja/models/note_model.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class DetalisNotePage extends StatefulWidget {
  const DetalisNotePage({required this.id, this.noteModel, super.key});
  final String id;
  final NoteModel? noteModel;

  @override
  State<DetalisNotePage> createState() => _DetalisNotePageState();
}

class _DetalisNotePageState extends State<DetalisNotePage> {
  var editing = false;
  String? note;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetalisCubit>(
      create: (context) => getIt()..getNoteWithID(widget.id),
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
            return const Scaffold(
              body: Text('Initial state'),
            );
          }
          if (state.status == Status.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
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
                        if (editing == false) ...[
                          PopupMenuItem<int>(
                            value: 0,
                            child: Text(
                              "Edit note ",
                              style: GoogleFonts.arimo(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 56, 55, 55),
                              ),
                            ),
                          ),
                        ],
                        if (editing == true) ...[
                          PopupMenuItem<int>(
                            value: 1,
                            child: Text(
                              "SAVE ",
                              style: GoogleFonts.arimo(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 56, 55, 55),
                              ),
                            ),
                          ),
                        ]
                      ];
                    },
                    onSelected: (value) {
                      if (value == 0) {
                        setState(() {
                          editing = true;
                        });
                      }
                      if (value == 1) {
                        context
                            .read<DetalisCubit>()
                            .editNote(documentID: noteModel!.id, note: note!);
                        setState(() {
                          editing = false;
                          context.read<DetalisCubit>().getNoteWithID(widget.id);
                        });
                      }
                    }),
              ],
              gradient:
                  const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
              title: Center(
                child: Text(
                  (noteModel!.releaseDate).toString(),
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
              child: ListView(
                children: [
                  if (editing == false) ...[
                    Text(
                      noteModel.note,
                      style: GoogleFonts.arimo(
                        fontSize: 16,
                      ),
                    ),
                  ],
                  if (editing == true) ...[
                    TextFormField(
                      initialValue: noteModel.note,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      maxLength: 1000,
                      maxLines: 30,
                      onChanged: (newValue) {
                        setState(() {
                          note = newValue;
                        });
                      },
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
