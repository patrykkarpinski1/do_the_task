import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'other_tasks_state.dart';

class OtherTasksCubit extends Cubit<OtherTasksState> {
  OtherTasksCubit() : super(const OtherTasksState());
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
        .where("category_id", isEqualTo: "u8xdtbT3eGo7dzoLbpS5")
        .snapshots()
        .listen(
      (tasks) {
        emit(
          OtherTasksState(
            tasks: tasks,
          ),
        );
      },
    )..onError((error) {
        {
          emit(
            const OtherTasksState(loadingErrorOccured: true),
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
        const OtherTasksState(loadingErrorOccured: true),
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
