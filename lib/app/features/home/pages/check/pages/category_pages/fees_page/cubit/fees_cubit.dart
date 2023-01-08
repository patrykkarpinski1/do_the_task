import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'fees_state.dart';

class FeesCubit extends Cubit<FeesState> {
  FeesCubit() : super(const FeesState());
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = FirebaseFirestore.instance
        .collection('tasks')
        .where("category_id", isEqualTo: "2sOimYJGU7kuX4MQCu3v")
        .snapshots()
        .listen(
      (tasks) {
        emit(
          FeesState(
            tasks: tasks,
          ),
        );
      },
    )..onError((error) {
        {
          emit(
            const FeesState(loadingErrorOccured: true),
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
        const FeesState(loadingErrorOccured: true),
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