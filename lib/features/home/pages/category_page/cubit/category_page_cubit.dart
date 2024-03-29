import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '/app/core/enums.dart';
import '/models/category_model.dart';
import '/repositories/item_repository.dart';

part 'category_page_state.dart';
part 'category_page_cubit.freezed.dart';

class CategoryPageCubit extends Cubit<CategoryPageState> {
  CategoryPageCubit({required this.itemsRepository})
      : super(CategoryPageState());
  final ItemsRepository itemsRepository;

  Future<void> start() async {
    emit(
      state.copyWith(
        status: Status.loading,
        categories: [],
      ),
    );
    try {
      final categories = await itemsRepository.getCategories();
      emit(state.copyWith(status: Status.success, categories: categories));
    } catch (error) {
      emit(state.copyWith(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> getCategoryWithID(String id) async {
    emit(
      state.copyWith(
        status: Status.loading,
        selectCategories: null,
      ),
    );
    try {
      final category = await itemsRepository.getCategory(id: id);
      emit(state.copyWith(status: Status.success, selectCategories: category));
    } catch (error) {
      emit(state.copyWith(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
