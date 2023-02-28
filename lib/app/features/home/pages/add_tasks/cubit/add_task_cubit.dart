import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit(
    this._itemsRepository,
  ) : super(AddTaskState());
  final ItemsRepository _itemsRepository;
  Future<void> start() async {
    emit(
      AddTaskState(
        status: Status.loading,
        categories: [],
      ),
    );
    try {
      final categories = await _itemsRepository.getCategories();
      emit(
        AddTaskState(
          status: Status.success,
          categories: categories
              .map((doc) => CategoryModel(id: doc.id, title: doc.title))
              .toList(),
        ),
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
      await _itemsRepository.addTasks(
          text, releaseDate, releaseTime, categoryId);
      emit(
        AddTaskState(
          saved: true,
        ),
      );
      start();
    } catch (error) {
      emit(
        AddTaskState(
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
