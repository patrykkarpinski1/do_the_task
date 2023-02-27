part of 'add_task_cubit.dart';

class AddTaskState {
  final String errorMessage;
  final String textNote;
  final bool saved;
  DateTime? releaseDate;
  TimeOfDay? releaseTime;
  final List<CategoryModel> categories;
  final bool isLoading;

  AddTaskState({
    this.releaseTime,
    this.releaseDate,
    this.errorMessage = '',
    this.textNote = '',
    this.saved = false,
    this.categories = const [],
    this.isLoading = false,
  });
}
