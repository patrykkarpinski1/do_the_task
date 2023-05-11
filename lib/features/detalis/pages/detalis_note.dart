import 'package:do_the_task/app/encryption.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/core/enums.dart';
import '/app/injection_container.dart';
import '/features/detalis/cubit/detalis_cubit.dart';
import '/models/note_model.dart';
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
          String decryptedNote = MyEncryptionDecription.decryptWithAESKey(
              noteModel?.note ?? 'Unkown');
          return Scaffold(
            appBar: NewGradientAppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              actions: [
                PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Theme.of(context).iconTheme.color,
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
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
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
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
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
              gradient: LinearGradient(colors: [
                Theme.of(context).focusColor,
                Theme.of(context).bottomAppBarColor,
              ]),
              title: Center(
                child: Text(
                  noteModel?.releaseDateFormatted() ?? 'Unkown',
                  style: GoogleFonts.arimo(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyText1!.color,
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
                      decryptedNote,
                      style: GoogleFonts.arimo(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                  ],
                  if (editing == true) ...[
                    TextFormField(
                      initialValue: decryptedNote,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                      ),
                      maxLength: 1000,
                      maxLines: 30,
                      onChanged: (newValue) {
                        setState(() {
                          note = MyEncryptionDecription.encryptWithAESKey(
                              newValue);
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
