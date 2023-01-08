import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'entertainment_state.dart';

class EntertainmentCubit extends Cubit<EntertainmentState> {
  EntertainmentCubit() : super(const EntertainmentState());
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = FirebaseFirestore.instance
        .collection('tasks')
        .where("category_id", isEqualTo: "VbUC8zzELkml61On2jBy")
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
      await FirebaseFirestore.instance
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
