part of 'house_cubit.dart';

class HouseState {
  final QuerySnapshot<Map<String, dynamic>>? tasks;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;

  const HouseState(
      {this.tasks,
      this.loadingErrorOccured = false,
      this.removingErrorOccured = false});
}
