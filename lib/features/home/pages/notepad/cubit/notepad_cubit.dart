import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/models/note_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'notepad_state.dart';
part 'notepad_cubit.freezed.dart';

class NotepadCubit extends Cubit<NotepadState> {
  NotepadCubit(this._itemsRepository) : super(NotepadState());
  final ItemsRepository _itemsRepository;
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(NotepadState(status: Status.loading));
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
        NotepadState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  Future<void> changetextNote(
    String newTextNote,
  ) async {
    emit(
      NotepadState(textNote: newTextNote),
    );
  }

  Future<void> add(
    String note,
    DateTime releaseDate,
  ) async {
    try {
      await _itemsRepository.addNote(note, releaseDate);
      emit(
        NotepadState(saved: true),
      );
    } catch (error) {
      emit(
        NotepadState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
