part of 'photo_note_cubit.dart';

@freezed
class PhotoNoteState with _$PhotoNoteState {
  factory PhotoNoteState({
    @Default([]) List<PhotoNoteModel> photos,
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(false) bool saved,
  }) = _PhotoNoteState;
}
