part of 'detalis_cubit.dart';

class DetalisState {
  final TaskModel? taskModel;
  final Status status;
  final String errorMessage;
  final PhotoNoteModel? photoNoteModel;
  final bool removingErrorOccured;
  final NoteModel? noteModel;

  DetalisState({
    this.removingErrorOccured = false,
    this.photoNoteModel,
    this.taskModel,
    this.status = Status.initial,
    this.errorMessage = '',
    this.noteModel,
  });
}
