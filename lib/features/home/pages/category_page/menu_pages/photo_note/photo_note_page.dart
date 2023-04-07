import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/injection_container.dart';
import 'package:modyfikacja_aplikacja/features/detalis/pages/detalis_photo_note.dart';
import 'package:modyfikacja_aplikacja/features/home/pages/category_page/menu_pages/photo_note/add_photo_page.dart';
import 'package:modyfikacja_aplikacja/features/home/pages/category_page/menu_pages/photo_note/cubit/photo_note_cubit.dart';
import 'package:modyfikacja_aplikacja/models/photo_note_model.dart';
import 'package:modyfikacja_aplikacja/widgets/photo_widget.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class PhotoNotePage extends StatelessWidget {
  const PhotoNotePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoNoteCubit>(
      create: (context) => getIt()..start(),
      child: BlocConsumer<PhotoNoteCubit, PhotoNoteState>(
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
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.status == Status.success) {
            final photoNoteModels = state.photos;
            return ViewPage(photoNoteModels: photoNoteModels);
          }

          return const ViewPage(
            photoNoteModels: [],
          );
        },
      ),
    );
  }
}

class ViewPage extends StatelessWidget {
  const ViewPage({
    Key? key,
    required this.photoNoteModels,
  }) : super(key: key);

  final List<PhotoNoteModel> photoNoteModels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
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
                      "Add Photo",
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
                if (value == 0) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                            value: context.read<PhotoNoteCubit>(),
                            child: const AddPhotoPage(),
                          )));
                }
              }),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 56, 55, 55),
          ),
        ),
        gradient: const LinearGradient(
          colors: [Colors.cyan, Colors.indigo],
        ),
        title: Text(
          'PHOTO NOTE',
          style: GoogleFonts.arimo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 56, 55, 55),
          ),
        ),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        children: [
          for (final photoNoteModel in photoNoteModels) ...[
            PhotoWidget(
                photoNoteModel: photoNoteModel,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => DetalisPhotoNotePage(
                              id: photoNoteModel.id,
                            )),
                  );
                }),
          ]
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 208, 225, 234),
    );
  }
}
