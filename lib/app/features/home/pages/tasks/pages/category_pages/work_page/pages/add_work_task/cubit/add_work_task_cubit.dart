import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'add_work_task_state.dart';

class AddWorkTaskCubit extends Cubit<AddWorkTaskState> {
  AddWorkTaskCubit(this._itemsRepository) : super(AddWorkTaskState());
  final ItemsRepository _itemsRepository;
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      AddWorkTaskState(
        errorMessage: '',
        textNote: '',
      ),
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
      await _itemsRepository.addWork(text, releaseDate, releaseTime);
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
