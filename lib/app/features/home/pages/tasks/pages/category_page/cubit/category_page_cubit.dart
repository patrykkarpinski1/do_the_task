import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'category_state.dart';

class CategoryPageCubit extends Cubit<CategoryPageState> {
  CategoryPageCubit(this._itemsRepository) : super(const CategoryPageState());
  final ItemsRepository _itemsRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const CategoryPageState(
        categories: [],
        isLoading: true,
        errorMessage: '',
      ),
    );
    _streamSubscription =
        _itemsRepository.getCategoriesStream().listen((categories) {
      emit(
        CategoryPageState(
          categories: categories,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
          ..onError((error) {
            {
              emit(
                CategoryPageState(
                  categories: const [],
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
