part of 'notebook_cubit.dart';

@immutable
class NotebookState {
  final QuerySnapshot<Map<String, dynamic>>? notes;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;

  const NotebookState({
    this.notes,
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
  });
}
