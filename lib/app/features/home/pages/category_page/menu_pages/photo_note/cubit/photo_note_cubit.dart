import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/models/photo_note_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';
part 'photo_note_state.dart';

class PhotoNoteCubit extends Cubit<PhotoNoteState> {
  PhotoNoteCubit(this._itemsRepository) : super(PhotoNoteState());
  final ItemsRepository _itemsRepository;

  Future<void> start() async {
    emit(
      PhotoNoteState(
        status: Status.loading,
        photos: [],
      ),
    );
    try {
      final photos = await _itemsRepository.getPhotos();
      emit(PhotoNoteState(status: Status.success, photos: photos));
    } catch (error) {
      emit(PhotoNoteState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> add(
    XFile image,
  ) async {
    try {
      await _itemsRepository.addPhotos(
        image,
      );
      emit(
        PhotoNoteState(
          saved: true,
        ),
      );
    } catch (error) {
      emit(
        PhotoNoteState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
