import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/detalis/pages/detalis_note.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/notepad/pages/notepad_page/cubit/notepad_cubit.dart';
import 'package:modyfikacja_aplikacja/models/note_model.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    Key? key,
    required this.noteModel,
  }) : super(key: key);
  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => DetalisNotePage(
                    id: noteModel.id,
                  )),
        );
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              SizedBox(
                width: 160,
                height: 115,
                child: Text(
                  noteModel.note,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      noteModel.releaseDateFormatted(),
                      style: GoogleFonts.gruppo(
                          color: const Color.fromARGB(255, 29, 28, 28),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<NotepadCubit>()
                            .remove(documentID: noteModel.id);
                      },
                      icon: const Icon(Icons.delete_sweep_outlined))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
