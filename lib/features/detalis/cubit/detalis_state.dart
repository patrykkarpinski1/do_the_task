part of 'detalis_cubit.dart';

@freezed
class DetalisState with _$DetalisState {
  factory DetalisState({
    TaskModel? taskModel,
    PhotoNoteModel? photoNoteModel,
    NoteModel? noteModel,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _DetalisState;
}
