import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '/app/core/enums.dart';
import '/models/note_model.dart';
import '/models/photo_note_model.dart';
import '/models/task_model.dart';
import '/repositories/item_repository.dart';

part 'detalis_state.dart';
part 'detalis_cubit.freezed.dart';

class DetalisCubit extends Cubit<DetalisState> {
  DetalisCubit({required this.itemsRepository}) : super(DetalisState());
  final ItemsRepository itemsRepository;
  Future<void> getTaskWithID(String id) async {
    emit(
      DetalisState(status: Status.loading, taskModel: null),
    );
    try {
      final taskModel = await itemsRepository.getDetalisTask(id: id);
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
      final photoNoteModel = await itemsRepository.getDetalisPhotoNote(
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
      await itemsRepository.deletePhotoStorage(photo: photo);
    } catch (error) {
      emit(
        DetalisState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> removePhotoDocument({
    required String documentID,
  }) async {
    try {
      await itemsRepository.deletePhotoDocument(
        id: documentID,
      );
    } catch (error) {
      emit(
        DetalisState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> getNoteWithID(String id) async {
    emit(
      DetalisState(status: Status.loading, noteModel: null),
    );
    try {
      final noteModel = await itemsRepository.getDetalisNote(id: id);
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
      await itemsRepository.editNote(id: documentID, note: note);
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
