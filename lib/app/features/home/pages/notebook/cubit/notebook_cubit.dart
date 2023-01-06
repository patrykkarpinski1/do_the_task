import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'notebook_state.dart';

class NotebookCubit extends Cubit<NotebookState> {
  NotebookCubit() : super(const NotebookState());

  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription =
        FirebaseFirestore.instance.collection('notepad').snapshots().listen(
      (notes) {
        emit(
          NotebookState(
            notes: notes,
          ),
        );
      },
    )..onError(
            (error) {
              {
                emit(
                  const NotebookState(loadingErrorOccured: true),
                );
              }
            },
          );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('notepad')
          .doc(documentID)
          .delete();
    } catch (error) {
      emit(
        const NotebookState(removingErrorOccured: true),
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
