part of 'tasks_page_cubit.dart';

@immutable
class TaskPageState {
  final List<CategoryModel> categories;
  final bool isLoading;
  final String errorMessage;

  const TaskPageState({
    this.categories = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });
}
