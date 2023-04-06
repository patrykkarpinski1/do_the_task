part of 'task_cubit.dart';

@freezed
class TaskState with _$TaskState {
  factory TaskState({
    @Default([]) List<TaskModel> tasks,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _TaskState;
}
