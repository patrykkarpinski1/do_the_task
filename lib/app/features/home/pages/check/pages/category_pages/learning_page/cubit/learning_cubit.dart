import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'learning_state.dart';

class LearningCubit extends Cubit<LearningState> {
  LearningCubit() : super(const LearningState());
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = FirebaseFirestore.instance
        .collection('tasks')
        .where("category_id", isEqualTo: "8I9GvUM1xDM9XSnHyxUb")
        .snapshots()
        .listen(
      (tasks) {
        emit(
          LearningState(
            tasks: tasks,
          ),
        );
      },
    )..onError((error) {
        {
          emit(
            const LearningState(loadingErrorOccured: true),
          );
        }
      });
  }

  Future<void> remove({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(documentID)
          .delete();
    } catch (error) {
      emit(
        const LearningState(loadingErrorOccured: true),
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
