import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit(this._itemsRepository) : super(const AddNoteState());
  final ItemsRepository _itemsRepository;

  Future<void> changetextNote(
    String newTextNote,
  ) async {
    emit(
      AddNoteState(textNote: newTextNote),
    );
  }

  Future<void> add(
    String note,
    DateTime releaseDate,
  ) async {
    try {
      await _itemsRepository.addNote(note, releaseDate);
      emit(
        const AddNoteState(saved: true),
      );
    } catch (error) {
      emit(
        AddNoteState(
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
