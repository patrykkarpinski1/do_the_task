import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';

part 'tasks_state.dart';

class TaskPageCubit extends Cubit<TaskPageState> {
  TaskPageCubit() : super(const TaskPageState());
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const TaskPageState(
        categories: [],
        isLoading: true,
        errorMessage: '',
      ),
    );
    _streamSubscription = FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .listen((categories) {
      final categoryModels = categories.docs.map((doc) {
        return (CategoryModel(
          id: doc.id,
          title: doc['title'],
        ));
      }).toList();
      emit(
        TaskPageState(
          categories: categoryModels,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        {
          emit(
            TaskPageState(
              categories: const [],
              isLoading: false,
              errorMessage: error.toString(),
            ),
          );
        }
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
