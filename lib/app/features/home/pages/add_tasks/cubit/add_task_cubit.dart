import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit(
    this._itemsRepository,
  ) : super(AddTaskState());
  final ItemsRepository _itemsRepository;
  Future<void> start() async {
    final categories = await _itemsRepository.getCategories();
    emit(AddTaskState(categories: categories));
  }

  // StreamSubscription? _streamSubscription;
  // Future<void> start() async {
  //   emit(
  //     AddTaskState(
  //       errorMessage: '',
  //       categories: [],
  //     ),
  //   );

  //   _streamSubscription =
  //       _itemsRepository.getCategoriesStream().listen((categories) {
  //     emit(
  //       AddTaskState(
  //         categories: categories,
  //         isLoading: false,
  //         errorMessage: '',
  //       ),
  //     );
  //   })
  //         ..onError((error) {
  //           {
  //             emit(
  //               AddTaskState(
  //                 categories: const [],
  //                 isLoading: false,
  //                 errorMessage: error.toString(),
  //               ),
  //             );
  //           }
  //         });
  // }

  Future<void> changetextNote(
    String newTextNote,
  ) async {
    emit(
      AddTaskState(textNote: newTextNote, categories: state.categories),
    );
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
        AddTaskState(saved: true),
      );
    } catch (error) {
      emit(
        AddTaskState(
          errorMessage: error.toString(),
        ),
      );
    }
  }

  // @override
  // Future<void> close() {
  //   _streamSubscription?.cancel();
  //   return super.close();
  // }
}
