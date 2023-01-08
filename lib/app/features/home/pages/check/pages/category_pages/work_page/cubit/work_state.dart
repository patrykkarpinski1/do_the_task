part of 'work_cubit.dart';

class WorkState {
  final QuerySnapshot<Map<String, dynamic>>? tasks;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;

  const WorkState(
      {this.tasks,
      this.loadingErrorOccured = false,
      this.removingErrorOccured = false});
}
