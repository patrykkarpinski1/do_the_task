part of 'category_page_cubit.dart';

@freezed
class CategoryPageState with _$CategoryPageState {
  factory CategoryPageState({
    @Default([]) List<CategoryModel> categories,
    @Default(Status.initial) Status status,
    String? errorMessage,
    CategoryModel? selectCategories,
  }) = _CategoryPageState;
}
