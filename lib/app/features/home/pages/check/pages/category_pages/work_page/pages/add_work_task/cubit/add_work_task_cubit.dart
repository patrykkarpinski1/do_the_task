import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

part 'add_work_task_state.dart';

class AddWorkTaskCubit extends Cubit<AddWorkTaskState> {
  AddWorkTaskCubit() : super(AddWorkTaskState());
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      AddWorkTaskState(
        errorMessage: '',
        textNote: '',
      ),
    );
  }

  Future<void> onDateChange() async {
    emit(
      AddWorkTaskState(),
    );
  }

  Future<void> changetextNote(
    String newTextNote,
  ) async {
    emit(
      AddWorkTaskState(textNote: newTextNote),
    );
  }

  Future<void> add(
    String text,
    DateTime releaseDate,
    TimeOfDay releaseTime,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        'text': text,
        'category_id': 'kmwtczQ4I989UJaG9ukI',
        'date': releaseDate,
      });
      emit(
        AddWorkTaskState(saved: true),
      );
    } catch (error) {
      emit(
        AddWorkTaskState(
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
