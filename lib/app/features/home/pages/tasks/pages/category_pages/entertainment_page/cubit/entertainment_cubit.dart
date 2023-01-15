import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'entertainment_state.dart';

class EntertainmentCubit extends Cubit<EntertainmentState> {
  EntertainmentCubit() : super(const EntertainmentState());
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = FirebaseFirestore.instance
        .collection('tasks')
        .where("category_id", isEqualTo: "4")
        .snapshots()
        .listen(
      (tasks) {
        emit(
          EntertainmentState(
            tasks: tasks,
          ),
        );
      },
    )..onError((error) {
        {
          emit(
            const EntertainmentState(loadingErrorOccured: true),
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
        const EntertainmentState(loadingErrorOccured: true),
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
