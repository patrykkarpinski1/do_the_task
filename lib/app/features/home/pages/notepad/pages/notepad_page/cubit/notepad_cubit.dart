import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modyfikacja_aplikacja/models/note_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'notepad_state.dart';

class NotepadCubit extends Cubit<NotepadState> {
  NotepadCubit(this._itemsRepository) : super(const NotepadState());
  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = _itemsRepository.getNotesStream().listen(
      (notes) {
        emit(
          NotepadState(
            notes: notes,
          ),
        );
      },
    )..onError(
        (error) {
          {
            emit(
              const NotepadState(loadingErrorOccured: true),
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
