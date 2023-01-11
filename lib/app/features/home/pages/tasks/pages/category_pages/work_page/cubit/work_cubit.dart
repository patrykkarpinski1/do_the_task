import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'work_state.dart';

class WorkCubit extends Cubit<WorkState> {
  WorkCubit(this._itemsRepository) : super(const WorkState());
  final ItemsRepository _itemsRepository;
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = _itemsRepository.getWorkStream().listen(
      (tasks) {
        emit(
          WorkState(
            tasks: tasks,
          ),
        );
      },
    )..onError((error) {
        {
          emit(
            const WorkState(loadingErrorOccured: true),
          );
        }
      });
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _itemsRepository.deleteWork(id: documentID);
    } catch (error) {
      emit(
        const WorkState(loadingErrorOccured: true),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
