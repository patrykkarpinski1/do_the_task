part of 'other_tasks_cubit.dart';

class OtherTasksState {
  final QuerySnapshot<Map<String, dynamic>>? tasks;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;

  const OtherTasksState(
      {this.tasks,
      this.loadingErrorOccured = false,
      this.removingErrorOccured = false});
}
