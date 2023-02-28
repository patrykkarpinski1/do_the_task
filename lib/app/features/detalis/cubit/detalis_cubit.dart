import 'package:bloc/bloc.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'detalis_state.dart';

class DetalisCubit extends Cubit<DetalisState> {
  DetalisCubit(this._itemsRepository) : super(DetalisState(taskModel: null));
  final ItemsRepository _itemsRepository;
  Future<void> getTaskWithID(String id) async {
    final taskModel = await _itemsRepository.getDetalisTask(id: id);
    emit(DetalisState(taskModel: taskModel));
  }
}
