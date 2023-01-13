import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sport_workouts_state.dart';

class SportWorkoutsCubit extends Cubit<SportWorkoutsState> {
  SportWorkoutsCubit() : super(const SportWorkoutsState());
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    _streamSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
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
      final userID = FirebaseAuth.instance.currentUser?.uid;
      if (userID == null) {
        throw Exception('User is not logged in');
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
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
