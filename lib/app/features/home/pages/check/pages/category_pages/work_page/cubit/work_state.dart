part of 'work_cubit.dart';

class WorkState {
  final List<TaskModel> tasks;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;

  const WorkState(
      {this.tasks = const [],
      this.loadingErrorOccured = false,
      this.removingErrorOccured = false});
}
