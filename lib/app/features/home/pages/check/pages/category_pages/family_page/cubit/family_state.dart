part of 'family_cubit.dart';

class FamilyState {
  final QuerySnapshot<Map<String, dynamic>>? tasks;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;

  const FamilyState(
      {this.tasks,
      this.loadingErrorOccured = false,
      this.removingErrorOccured = false});
}
