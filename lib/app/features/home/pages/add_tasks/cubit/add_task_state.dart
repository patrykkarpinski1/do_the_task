part of 'add_task_cubit.dart';

class AddTaskState {
  final String errorMessage;
  final String textNote;
  final bool saved;

  AddTaskState({
    this.errorMessage = '',
    this.textNote = '',
    this.saved = false,
  });
}
