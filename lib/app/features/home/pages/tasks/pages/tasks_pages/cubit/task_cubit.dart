import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this._itemsRepository) : super(const TaskState());
  final ItemsRepository _itemsRepository;

  Future<void> getTasks(
    int categoryId,
  ) async {
    try {
      final results = await _itemsRepository.getTasks(
        categoryId,
      );
      emit(
        TaskState(tasks: results),
      );
    } catch (error) {
      emit(
        const TaskState(
          removingErrorOccured: true,
        ),
      );
    }
  }

  Future<void> remove({
    required String documentID,
    required int categoryId,
  }) async {
    try {
      await _itemsRepository.deleteTask(id: documentID);
    } catch (error) {
      emit(
        const TaskState(removingErrorOccured: true),
      );
      getTasks(categoryId);
    }
  }
}
