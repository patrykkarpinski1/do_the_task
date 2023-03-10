import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/category_page/menu_pages/photo_note/add_photo_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/category_page/menu_pages/photo_note/cubit/photo_note_cubit.dart';
import 'package:modyfikacja_aplikacja/models/photo_note_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class PhotoNotePage extends StatelessWidget {
  const PhotoNotePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoNoteCubit(ItemsRepository())..start(),
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == Status.success) {
            if (state.photos.isEmpty) {
              return const SizedBox.shrink();
            }
          }
          final photoNoteModels = state.photos;
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
                            builder: (_) => const AddPhotoPage()));
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
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  for (final photoNoteModel in photoNoteModels) ...[
                    PhotoWidget(photoNoteModel: photoNoteModel),
                  ]
                ],
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 208, 225, 234),
          );
        },
      ),
    );
  }
}

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    required this.photoNoteModel,
    Key? key,
  }) : super(key: key);
  final PhotoNoteModel? photoNoteModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Image(image: NetworkImage(photoNoteModel!.photo)));
  }
}
