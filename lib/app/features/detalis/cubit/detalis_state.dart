part of 'detalis_cubit.dart';

class DetalisState {
  final TaskModel? taskModel;
  final Status status;
  final String? errorMessage;
  final NoteModel? noteModel;

  DetalisState({
    this.noteModel,
    this.taskModel,
    this.status = Status.initial,
    this.errorMessage = '',
  });
}
