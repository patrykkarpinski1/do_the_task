part of 'add_work_task_cubit.dart';

class AddWorkTaskState {
  final String errorMessage;
  final String textNote;
  final bool saved;
  DateTime? releaseDate;
  TimeOfDay? releaseTime;

  AddWorkTaskState({
    this.releaseTime,
    this.releaseDate,
    this.errorMessage = '',
    this.textNote = '',
    this.saved = false,
  });
}
