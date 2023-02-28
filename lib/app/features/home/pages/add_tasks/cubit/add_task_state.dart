part of 'add_task_cubit.dart';

class AddTaskState {
  final String? errorMessage;
  final bool saved;
  DateTime? releaseDate;
  TimeOfDay? releaseTime;
  final List<CategoryModel> categories;
  final Status status;

  AddTaskState({
    this.status = Status.initial,
    this.releaseTime,
    this.releaseDate,
    this.errorMessage = '',
    this.saved = false,
    this.categories = const [],
  });
}
