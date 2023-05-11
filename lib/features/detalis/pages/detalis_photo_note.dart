import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/app/core/enums.dart';
import '/app/injection_container.dart';
import '/features/detalis/cubit/detalis_cubit.dart';
import '/models/photo_note_model.dart';
import '/widgets/show_alert_dialog_widget.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class DetalisPhotoNotePage extends StatelessWidget {
  const DetalisPhotoNotePage(
      {required this.id, this.photoNoteModel, super.key});
  final String id;
  final PhotoNoteModel? photoNoteModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetalisCubit>(
      create: (context) => getIt()..getPhotoWithID(id),
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
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
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
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                actions: [
                  AlertWidget(
                    onPressed: () {
                      context
                          .read<DetalisCubit>()
                          .removePhotoStorage(photo: photoNoteModel!.photo);
                      context
                          .read<DetalisCubit>()
                          .removePhotoDocument(documentID: photoNoteModel.id);

                      Navigator.pop(context, true);
                      Navigator.pop(context, true);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  )
                ],
                gradient: LinearGradient(colors: [
                  Theme.of(context).focusColor,
                  Theme.of(context).bottomAppBarColor,
                ]),
              ),
              body: Center(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Hero(
                        tag: photoNoteModel!.id,
                        child: FadeInImage(
                          placeholder: const AssetImage('images/reload.png'),
                          image: NetworkImage(
                            photoNoteModel.photo,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
