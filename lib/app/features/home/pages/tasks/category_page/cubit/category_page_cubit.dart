import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'category_page_state.dart';

class CategoryPageCubit extends Cubit<CategoryPageState> {
  CategoryPageCubit(this._itemsRepository) : super(const CategoryPageState());
  final ItemsRepository _itemsRepository;

  Future<void> start() async {
    emit(
      const CategoryPageState(
        status: Status.loading,
        categories: [],
      ),
    );
    try {
      final categories = await _itemsRepository.getCategories();
      emit(CategoryPageState(status: Status.success, categories: categories));
    } catch (error) {
      emit(CategoryPageState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> getCategoryWithID(String id) async {
    emit(
      const CategoryPageState(
        status: Status.loading,
        categoryModel: null,
      ),
    );
    try {
      final categoryModel = await _itemsRepository.getCategory(id: id);
      emit(CategoryPageState(
          status: Status.success, categoryModel: categoryModel));
    } catch (error) {
      emit(CategoryPageState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
