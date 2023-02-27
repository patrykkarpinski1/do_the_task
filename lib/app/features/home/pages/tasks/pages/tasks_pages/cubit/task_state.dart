part of 'task_cubit.dart';

class TaskState {
  final bool loadingErrorOccured;
  final bool removingErrorOccured;
  final List<TaskModel> tasks;

  const TaskState({
    this.tasks = const [],
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
  });
}
