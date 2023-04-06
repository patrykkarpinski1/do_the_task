// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_page_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CategoryPageState {
  List<CategoryModel> get categories => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  CategoryModel? get categoryModel => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryPageStateCopyWith<CategoryPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryPageStateCopyWith<$Res> {
  factory $CategoryPageStateCopyWith(
          CategoryPageState value, $Res Function(CategoryPageState) then) =
      _$CategoryPageStateCopyWithImpl<$Res, CategoryPageState>;
  @useResult
  $Res call(
      {List<CategoryModel> categories,
      Status status,
      String? errorMessage,
      CategoryModel? categoryModel});

  $CategoryModelCopyWith<$Res>? get categoryModel;
}

/// @nodoc
class _$CategoryPageStateCopyWithImpl<$Res, $Val extends CategoryPageState>
    implements $CategoryPageStateCopyWith<$Res> {
  _$CategoryPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? categoryModel = freezed,
  }) {
    return _then(_value.copyWith(
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryModel: freezed == categoryModel
          ? _value.categoryModel
          : categoryModel // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryModelCopyWith<$Res>? get categoryModel {
    if (_value.categoryModel == null) {
      return null;
    }

    return $CategoryModelCopyWith<$Res>(_value.categoryModel!, (value) {
      return _then(_value.copyWith(categoryModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CategoryPageStateCopyWith<$Res>
    implements $CategoryPageStateCopyWith<$Res> {
  factory _$$_CategoryPageStateCopyWith(_$_CategoryPageState value,
          $Res Function(_$_CategoryPageState) then) =
      __$$_CategoryPageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CategoryModel> categories,
      Status status,
      String? errorMessage,
      CategoryModel? categoryModel});

  @override
  $CategoryModelCopyWith<$Res>? get categoryModel;
}

/// @nodoc
class __$$_CategoryPageStateCopyWithImpl<$Res>
    extends _$CategoryPageStateCopyWithImpl<$Res, _$_CategoryPageState>
    implements _$$_CategoryPageStateCopyWith<$Res> {
  __$$_CategoryPageStateCopyWithImpl(
      _$_CategoryPageState _value, $Res Function(_$_CategoryPageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? categoryModel = freezed,
  }) {
    return _then(_$_CategoryPageState(
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryModel: freezed == categoryModel
          ? _value.categoryModel
          : categoryModel // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
    ));
  }
}

/// @nodoc

class _$_CategoryPageState implements _CategoryPageState {
  _$_CategoryPageState(
      {final List<CategoryModel> categories = const [],
      this.status = Status.initial,
      this.errorMessage,
      this.categoryModel})
      : _categories = categories;

  final List<CategoryModel> _categories;
  @override
  @JsonKey()
  List<CategoryModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final Status status;
  @override
  final String? errorMessage;
  @override
  final CategoryModel? categoryModel;

  @override
  String toString() {
    return 'CategoryPageState(categories: $categories, status: $status, errorMessage: $errorMessage, categoryModel: $categoryModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CategoryPageState &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.categoryModel, categoryModel) ||
                other.categoryModel == categoryModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      status,
      errorMessage,
      categoryModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CategoryPageStateCopyWith<_$_CategoryPageState> get copyWith =>
      __$$_CategoryPageStateCopyWithImpl<_$_CategoryPageState>(
          this, _$identity);
}

abstract class _CategoryPageState implements CategoryPageState {
  factory _CategoryPageState(
      {final List<CategoryModel> categories,
      final Status status,
      final String? errorMessage,
      final CategoryModel? categoryModel}) = _$_CategoryPageState;

  @override
  List<CategoryModel> get categories;
  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  CategoryModel? get categoryModel;
  @override
  @JsonKey(ignore: true)
  _$$_CategoryPageStateCopyWith<_$_CategoryPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
