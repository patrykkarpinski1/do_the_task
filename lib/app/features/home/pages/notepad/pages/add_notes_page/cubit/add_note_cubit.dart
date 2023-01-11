import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(const AddNoteState());
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      const AddNoteState(
        errorMessage: '',
        textNote: '',
      ),
    );
  }

  Future<void> changetextNote(
    String newTextNote,
  ) async {
    emit(
      AddNoteState(textNote: newTextNote),
    );
  }

  Future<void> add(String note) async {
    try {
      await FirebaseFirestore.instance.collection('notepad').add(
        {'note': note},
      );
      emit(
        const AddNoteState(saved: true),
      );
    } catch (error) {
      emit(
        AddNoteState(
          errorMessage: error.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
