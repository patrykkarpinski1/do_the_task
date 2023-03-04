import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this._itemsRepository) : super(const TaskState());
  final ItemsRepository _itemsRepository;

  Future<void> getTasks(
    String categoryId,
  ) async {
    emit(
      const TaskState(
        status: Status.loading,
        tasks: [],
      ),
    );
    try {
      final results = await _itemsRepository.getTasks(
        categoryId: categoryId,
      );
      emit(
        TaskState(
          status: Status.success,
          tasks: results,
        ),
      );
    } catch (error) {
      emit(
        TaskState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> remove({
    required String documentID,
    String? categoryId,
  }) async {
    try {
      await _itemsRepository.deleteTask(id: documentID);
    } catch (error) {
      emit(
        const TaskState(removingErrorOccured: true),
      );
      getTasks(categoryId!);
    }
  }
}
