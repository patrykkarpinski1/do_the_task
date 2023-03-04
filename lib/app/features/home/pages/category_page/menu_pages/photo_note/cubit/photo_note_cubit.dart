import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/models/photo_note_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'photo_note_state.dart';

class PhotoNoteCubit extends Cubit<PhotoNoteState> {
  PhotoNoteCubit(this._itemsRepository) : super(const PhotoNoteState());
  final ItemsRepository _itemsRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(const PhotoNoteState(status: Status.loading));
    _streamSubscription = _itemsRepository.getPhotosStream().listen(
      (photos) {
        emit(
          PhotoNoteState(
            status: Status.success,
            photos: photos,
          ),
        );
      },
    )..onError(
        (error) {
          {
            emit(
              PhotoNoteState(
                status: Status.error,
                errorMessage: error.toString(),
              ),
            );
          }
        },
      );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
