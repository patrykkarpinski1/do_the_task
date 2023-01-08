part of 'notepad_cubit.dart';

@immutable
class NotepadState {
  final QuerySnapshot<Map<String, dynamic>>? notes;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;

  const NotepadState({
    this.notes,
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
  });
}
