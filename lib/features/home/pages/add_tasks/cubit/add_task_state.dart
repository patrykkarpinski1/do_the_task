part of 'add_task_cubit.dart';

class AddTaskState {
  final String errorMessage;
  final bool saved;
  final List<CategoryModel> categories;
  final Status status;

  AddTaskState({
    this.status = Status.initial,
    this.errorMessage = '',
    this.saved = false,
    this.categories = const [],
  });
}
