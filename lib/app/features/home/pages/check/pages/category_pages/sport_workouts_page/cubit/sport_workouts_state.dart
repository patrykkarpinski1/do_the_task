part of 'sport_workouts_cubit.dart';

class SportWorkoutsState {
  final QuerySnapshot<Map<String, dynamic>>? tasks;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;

  const SportWorkoutsState(
      {this.tasks,
      this.loadingErrorOccured = false,
      this.removingErrorOccured = false});
}
