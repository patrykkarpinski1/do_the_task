part of 'add_task_cubit.dart';

@freezed
class AddTaskState with _$AddTaskState {
  factory AddTaskState({
    @Default([]) List<CategoryModel> categories,
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(false) bool saved,
  }) = _AddTaskState;
}
