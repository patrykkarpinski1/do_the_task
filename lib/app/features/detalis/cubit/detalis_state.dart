part of 'detalis_cubit.dart';

class DetalisState {
  final TaskModel? taskModel;
  final Status status;
  final String? errorMessage;
  final NoteModel? noteModel;
  final PhotoNoteModel? photoNoteModel;

  DetalisState({
    this.photoNoteModel,
    this.noteModel,
    this.taskModel,
    this.status = Status.initial,
    this.errorMessage = '',
  });
}
