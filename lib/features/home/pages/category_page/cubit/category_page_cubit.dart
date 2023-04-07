import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'category_page_state.dart';
part 'category_page_cubit.freezed.dart';

@injectable
class CategoryPageCubit extends Cubit<CategoryPageState> {
  CategoryPageCubit({required this.itemsRepository})
      : super(CategoryPageState());
  final ItemsRepository itemsRepository;

  Future<void> start() async {
    emit(
      CategoryPageState(
        status: Status.loading,
        categories: [],
      ),
    );
    try {
      final categories = await itemsRepository.getCategories();
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
      CategoryPageState(
        status: Status.loading,
        categoryModel: null,
      ),
    );
    try {
      final categoryModel = await itemsRepository.getCategory(id: id);
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
