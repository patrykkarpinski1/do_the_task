import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'sport_workouts_state.dart';

class SportWorkoutsCubit extends Cubit<SportWorkoutsState> {
  SportWorkoutsCubit() : super(const SportWorkoutsState());
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = FirebaseFirestore.instance
        .collection('tasks')
        .where("category_id", isEqualTo: "mW4XEXybkI8axLObJXi7")
        .snapshots()
        .listen(
      (tasks) {
        emit(
          SportWorkoutsState(
            tasks: tasks,
          ),
        );
      },
    )..onError((error) {
        {
          emit(
            const SportWorkoutsState(loadingErrorOccured: true),
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
        const SportWorkoutsState(loadingErrorOccured: true),
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
