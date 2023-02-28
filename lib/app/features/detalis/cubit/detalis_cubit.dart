import 'package:bloc/bloc.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'detalis_state.dart';

class DetalisCubit extends Cubit<DetalisState> {
  DetalisCubit(this._itemsRepository) : super(DetalisState(taskModel: null));
  final ItemsRepository _itemsRepository;
  Future<void> getTaskWithID(String id) async {
    emit(
      DetalisState(status: Status.loading, taskModel: null),
    );
    try {
      final taskModel = await _itemsRepository.getDetalisTask(id: id);
      emit(DetalisState(status: Status.success, taskModel: taskModel));
    } catch (error) {
      emit(
        DetalisState(
          status: Status.error,
          errorMessage: error.toString(),
          taskModel: null,
        ),
      );
    }
  }
}
