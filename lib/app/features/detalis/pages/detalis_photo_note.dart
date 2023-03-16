import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/features/detalis/cubit/detalis_cubit.dart';
import 'package:modyfikacja_aplikacja/data/remote_data_sources/items_remote_data_source.dart';
import 'package:modyfikacja_aplikacja/models/photo_note_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class DetalisPhotoNotePage extends StatelessWidget {
  const DetalisPhotoNotePage(
      {required this.id, this.photoNoteModel, super.key});
  final String id;
  final PhotoNoteModel? photoNoteModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetalisCubit(ItemsRepository(ItemsRemoteDataSources()))
            ..getPhotoWithID(id),
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
            if (state.photoNoteModel == null) {
              return const SizedBox.shrink();
            }
          }
          final photoNoteModel = state.photoNoteModel;
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
                gradient:
                    const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
              ),
              body: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Image(
                        image: NetworkImage(
                          photoNoteModel!.photo,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context
                              .read<DetalisCubit>()
                              .remove(documentID: photoNoteModel.id);

                          Navigator.of(context).pop();
                        },
                        child: const Text('Delete'))
                  ],
                ),
              ));
        },
      ),
    );
  }
}
