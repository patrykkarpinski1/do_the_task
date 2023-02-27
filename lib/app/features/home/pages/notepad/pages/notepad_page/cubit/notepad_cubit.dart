import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/models/note_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'notepad_state.dart';

class NotepadCubit extends Cubit<NotepadState> {
  NotepadCubit(this._itemsRepository) : super(const NotepadState());
  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(const NotepadState(status: Status.loading));
    _streamSubscription = _itemsRepository.getNotesStream().listen(
      (notes) {
        emit(
          NotepadState(
            status: Status.success,
            notes: notes,
          ),
        );
      },
    )..onError(
        (error) {
          {
            emit(
              NotepadState(
                status: Status.error,
                errorMessage: error.toString(),
              ),
            );
          }
        },
      );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _itemsRepository.deleteNote(id: documentID);
    } catch (error) {
      emit(
        const NotepadState(removingErrorOccured: true),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
