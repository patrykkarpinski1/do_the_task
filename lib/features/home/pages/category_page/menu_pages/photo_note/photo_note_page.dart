import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/core/enums.dart';
import '/app/injection_container.dart';
import '/features/detalis/pages/detalis_photo_note.dart';
import '/features/home/pages/category_page/menu_pages/photo_note/add_photo_page.dart';
import '/features/home/pages/category_page/menu_pages/photo_note/cubit/photo_note_cubit.dart';
import '/models/photo_note_model.dart';
import '/widgets/photo_widget.dart';
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
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).iconTheme.color,
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
                        color: Theme.of(context).textTheme.bodyText1!.color,
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
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).focusColor,
            Theme.of(context).bottomAppBarColor,
          ],
        ),
        title: Text(
          'PHOTO NOTE',
          style: GoogleFonts.arimo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyText1!.color,
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
    );
  }
}
