import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'check_page_state.dart';

class CheckPageCubit extends Cubit<CheckPageState> {
  CheckPageCubit()
      : super(const CheckPageState(
          documents: [],
          isLoading: false,
          errorMessage: '',
        ));
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const CheckPageState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );
    _streamSubscription = FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .listen((data) {
      emit(
        CheckPageState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        {
          emit(
            CheckPageState(
              documents: const [],
              isLoading: false,
              errorMessage: error.toString(),
            ),
          );
        }
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
