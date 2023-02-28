part of 'task_cubit.dart';

class TaskState {
  final bool loadingErrorOccured;
  final bool removingErrorOccured;
  final List<TaskModel> tasks;
  final Status status;
  final String? errorMessage;

  const TaskState({
    this.tasks = const [],
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
    this.status = Status.initial,
    this.errorMessage = '',
  });
}
