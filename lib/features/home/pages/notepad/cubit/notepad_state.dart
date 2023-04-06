part of 'notepad_cubit.dart';

@freezed
class NotepadState with _$NotepadState {
  factory NotepadState(
      {@Default([]) List<NoteModel> notes,
      @Default(Status.initial) Status status,
      String? errorMessage,
      @Default(false) bool saved,
      @Default('') String textNote}) = _NotepadState;
}
