import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '/app/core/enums.dart';
import '/models/category_model.dart';
import '/repositories/item_repository.dart';

part 'add_task_state.dart';
part 'add_task_cubit.freezed.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit({
    required this.itemsRepository,
  }) : super(AddTaskState());
  final ItemsRepository itemsRepository;
  Future<void> fetch() async {
    emit(
      state.copyWith(
        status: Status.loading,
        categories: [],
      ),
    );
    try {
      final categories = await itemsRepository.getCategories();
      emit(
        state.copyWith(status: Status.success, categories: categories),
      );
    } catch (error) {
      emit(state.copyWith(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> add(
    String text,
    DateTime releaseDate,
    TimeOfDay releaseTime,
    String categoryId,
  ) async {
    try {
      await itemsRepository.addTasks(
          text, releaseDate, releaseTime, categoryId);
      emit(
        state.copyWith(
          saved: true,
        ),
      );
      fetch();
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
