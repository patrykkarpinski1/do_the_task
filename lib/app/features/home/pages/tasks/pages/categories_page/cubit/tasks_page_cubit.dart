import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'tasks_state.dart';

class TaskPageCubit extends Cubit<TaskPageState> {
  TaskPageCubit(this._itemsRepository) : super(const TaskPageState());
  final ItemsRepository _itemsRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const TaskPageState(
        categories: [],
        isLoading: true,
        errorMessage: '',
      ),
    );
    _streamSubscription =
        _itemsRepository.getCategoriesStream().listen((categories) {
      emit(
        TaskPageState(
          categories: categories,
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
