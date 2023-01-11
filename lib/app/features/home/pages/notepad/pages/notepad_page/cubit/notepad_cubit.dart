import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:modyfikacja_aplikacja/models/note_model.dart';

part 'notepad_state.dart';

class NotepadCubit extends Cubit<NotepadState> {
  NotepadCubit() : super(const NotepadState());

  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription =
        FirebaseFirestore.instance.collection('notepad').snapshots().listen(
      (notes) {
        final noteModels = notes.docs.map((doc) {
          return NoteModel(
            note: doc['note'],
            id: doc.id,
          );
        }).toList();
        emit(
          NotepadState(
            notes: noteModels,
          ),
        );
      },
    )..onError(
            (error) {
              {
                emit(
                  const NotepadState(loadingErrorOccured: true),
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
        const NotepadState(removingErrorOccured: true),
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
