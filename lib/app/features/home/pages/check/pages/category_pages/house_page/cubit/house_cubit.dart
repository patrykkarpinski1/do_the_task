import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'house_state.dart';

class HouseCubit extends Cubit<HouseState> {
  HouseCubit() : super(const HouseState());

  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = FirebaseFirestore.instance
        .collection('tasks')
        .where("category_id", isEqualTo: "wRhqK5cwqBaQdrkPk6nT")
        .snapshots()
        .listen(
      (tasks) {
        emit(
          HouseState(
            tasks: tasks,
          ),
        );
      },
    )..onError((error) {
        {
          emit(
            const HouseState(loadingErrorOccured: true),
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
        const HouseState(loadingErrorOccured: true),
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
