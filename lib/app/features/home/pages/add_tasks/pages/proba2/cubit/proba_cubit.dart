import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:modyfikacja_aplikacja/models/list/category_model2.dart';
import 'dart:async';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'proba_state.dart';

class ProbaCubit extends Cubit<ProbaState> {
  ProbaCubit(
    this._itemsRepository,
  ) : super(ProbaState());
  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      ProbaState(
        errorMessage: '',
        textNote: '',
        categories: [],
      ),
    );

    _streamSubscription =
        _itemsRepository.getCategoriesStream2().listen((categories) {
      emit(
        ProbaState(
          categories: categories,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
          ..onError((error) {
            {
              emit(
                ProbaState(
                  categories: const [],
                  isLoading: false,
                  errorMessage: error.toString(),
                ),
              );
            }
          });
  }

  Future<void> changetextNote(
    String newTextNote,
  ) async {
    emit(
      ProbaState(textNote: newTextNote),
    );
  }

  Future<void> add(
    String text,
    DateTime releaseDate,
    TimeOfDay releaseTime,
    String categoryId,
  ) async {
    try {
      await _itemsRepository.addProba(
          text, releaseDate, releaseTime, categoryId);
      emit(
        ProbaState(saved: true),
      );
    } catch (error) {
      emit(
        ProbaState(
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
