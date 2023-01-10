part of 'add_note_cubit.dart';

class AddNoteState {
  final String errorMessage;
  final String textNote;
  final bool saved;

  const AddNoteState({
    this.errorMessage = '',
    this.textNote = '',
    this.saved = false,
  });
}
