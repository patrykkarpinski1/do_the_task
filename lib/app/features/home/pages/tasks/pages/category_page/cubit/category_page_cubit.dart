import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

part 'category_state.dart';

class CategoryPageCubit extends Cubit<CategoryPageState> {
  CategoryPageCubit(this._itemsRepository) : super(const CategoryPageState());
  final ItemsRepository _itemsRepository;

  Future<void> start() async {
    final categories = await _itemsRepository.getCategories();
    emit(CategoryPageState(categories: categories));
  }

  Future<void> getCategoryWithID(String id) async {
    final categoryModel = await _itemsRepository.getCategory(id: id);
    emit(CategoryPageState(categoryModel: categoryModel));
  }
  // StreamSubscription? _streamSubscription;

  // Future<void> start() async {
  //   emit(
  //     const CategoryPageState(
  //       categories: [],
  //       isLoading: true,
  //       errorMessage: '',
  //     ),
  //   );
  //   _streamSubscription =
  //       _itemsRepository.getCategoriesStream().listen((categories) {
  //     emit(
  //       CategoryPageState(
  //         categories: categories,
  //         isLoading: false,
  //         errorMessage: '',
  //       ),
  //     );
  //   })
  //         ..onError((error) {
  //           {
  //             emit(
  //               CategoryPageState(
  //                 categories: const [],
  //                 isLoading: false,
  //                 errorMessage: error.toString(),
  //               ),
  //             );
  //           }
  //         });
  // }

  // @override
  // Future<void> close() {
  //   _streamSubscription?.cancel();
  //   return super.close();
  // }
}
