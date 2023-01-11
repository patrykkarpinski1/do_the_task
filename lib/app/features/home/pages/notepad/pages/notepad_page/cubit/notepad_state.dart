part of 'notepad_cubit.dart';

@immutable
class NotepadState {
  final List<NoteModel> notes;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;

  const NotepadState({
    this.notes = const [],
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
  });
}
