import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/models/photo_note_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';
part 'photo_note_state.dart';
part 'photo_note_cubit.freezed.dart';

@injectable
class PhotoNoteCubit extends Cubit<PhotoNoteState> {
  PhotoNoteCubit({required this.itemsRepository}) : super(PhotoNoteState());
  final ItemsRepository itemsRepository;
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(PhotoNoteState(status: Status.loading));
    _streamSubscription = itemsRepository.getPhotosStream().listen(
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

  Future<void> add(
    XFile image,
  ) async {
    try {
      await itemsRepository.addPhotos(
        image,
      );
      emit(
        PhotoNoteState(saved: true),
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
