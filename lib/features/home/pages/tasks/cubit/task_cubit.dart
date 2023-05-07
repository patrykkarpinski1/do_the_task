import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '/app/core/enums.dart';
import '/models/task_model.dart';
import '/repositories/item_repository.dart';

part 'task_state.dart';
part 'task_cubit.freezed.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit({required this.itemsRepository}) : super(TaskState());
  final ItemsRepository itemsRepository;

  Future<void> getTasks(
    String categoryId,
  ) async {
    emit(
      TaskState(
        status: Status.loading,
        tasks: [],
      ),
    );
    try {
      final results = await itemsRepository.getTasks(
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
      await itemsRepository.deleteTask(id: documentID);
    } catch (error) {
      emit(
        TaskState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
      if (categoryId != null) {
        getTasks(categoryId);
      }
    }
  }
}
