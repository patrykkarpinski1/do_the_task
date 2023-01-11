import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';

part 'work_state.dart';

class WorkCubit extends Cubit<WorkState> {
  WorkCubit() : super(const WorkState());
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = FirebaseFirestore.instance
        .collection('tasks')
        .where("category_id", isEqualTo: "kmwtczQ4I989UJaG9ukI")
        .snapshots()
        .listen(
      (tasks) {
        final taskModels = tasks.docs.map((doc) {
          return (TaskModel(
            id: doc.id,
            text: doc['text'],
            releaseDate: (doc['date'] as Timestamp).toDate(),
          ));
        }).toList();
        emit(
          WorkState(
            tasks: taskModels,
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
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(documentID)
          .delete();
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
