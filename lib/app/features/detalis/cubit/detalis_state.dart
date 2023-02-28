part of 'detalis_cubit.dart';

class DetalisState {
  final TaskModel? taskModel;
  final Status status;
  final String? errorMessage;

  DetalisState({
    required this.taskModel,
    this.status = Status.initial,
    this.errorMessage = '',
  });
}
