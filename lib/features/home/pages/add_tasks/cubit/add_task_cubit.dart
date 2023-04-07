import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'add_task_state.dart';
part 'add_task_cubit.freezed.dart';

@injectable
class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit({
    required this.itemsRepository,
  }) : super(AddTaskState());
  final ItemsRepository itemsRepository;
  Future<void> fetch() async {
    emit(
      AddTaskState(
        status: Status.loading,
        categories: [],
      ),
    );
    try {
      final categories = await itemsRepository.getCategories();
      emit(
        AddTaskState(status: Status.success, categories: categories),
      );
    } catch (error) {
      emit(AddTaskState(
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
        AddTaskState(
          saved: true,
        ),
      );
      fetch();
    } catch (error) {
      emit(
        AddTaskState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
