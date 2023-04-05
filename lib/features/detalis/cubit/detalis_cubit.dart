import 'package:bloc/bloc.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/models/note_model.dart';
import 'package:modyfikacja_aplikacja/models/photo_note_model.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'detalis_state.dart';

class DetalisCubit extends Cubit<DetalisState> {
  DetalisCubit(this._itemsRepository) : super(DetalisState());
  final ItemsRepository _itemsRepository;
  Future<void> getTaskWithID(String id) async {
    emit(
      DetalisState(status: Status.loading, taskModel: null),
    );
    try {
      final taskModel = await _itemsRepository.getDetalisTask(id: id);
      emit(DetalisState(status: Status.success, taskModel: taskModel));
    } catch (error) {
      emit(
        DetalisState(
          status: Status.error,
          errorMessage: error.toString(),
          taskModel: null,
        ),
      );
    }
  }

  Future<void> getPhotoWithID(String id) async {
    emit(
      DetalisState(status: Status.loading, photoNoteModel: null),
    );
    try {
      final photoNoteModel = await _itemsRepository.getDetalisPhotoNote(
        id: id,
      );
      emit(
          DetalisState(status: Status.success, photoNoteModel: photoNoteModel));
    } catch (error) {
      emit(
        DetalisState(
          status: Status.error,
          errorMessage: error.toString(),
          photoNoteModel: null,
        ),
      );
    }
  }

  Future<void> removePhotoStorage({
    required String photo,
  }) async {
    try {
      await _itemsRepository.deletePhotoStorage(photo: photo);
    } catch (error) {
      emit(
        DetalisState(removingErrorOccured: true),
      );
    }
  }

  Future<void> removePhotoDocument({
    required String documentID,
  }) async {
    try {
      await _itemsRepository.deletePhoto2(
        id: documentID,
      );
    } catch (error) {
      emit(
        DetalisState(removingErrorOccured: true),
      );
    }
  }

  Future<void> getNoteWithID(String id) async {
    emit(
      DetalisState(status: Status.loading, noteModel: null),
    );
    try {
      final noteModel = await _itemsRepository.getDetalisNote(id: id);
      emit(DetalisState(status: Status.success, noteModel: noteModel));
    } catch (error) {
      emit(
        DetalisState(
          status: Status.error,
          errorMessage: error.toString(),
          noteModel: null,
        ),
      );
    }
  }

  Future<void> editNote(
      {required String documentID, required String note}) async {
    try {
      await _itemsRepository.editNote(id: documentID, note: note);
    } catch (error) {
      emit(
        DetalisState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
