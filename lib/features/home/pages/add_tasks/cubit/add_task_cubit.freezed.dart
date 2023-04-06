// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_task_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddTaskState {
  List<CategoryModel> get categories => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get saved => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddTaskStateCopyWith<AddTaskState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTaskStateCopyWith<$Res> {
  factory $AddTaskStateCopyWith(
          AddTaskState value, $Res Function(AddTaskState) then) =
      _$AddTaskStateCopyWithImpl<$Res, AddTaskState>;
  @useResult
  $Res call(
      {List<CategoryModel> categories,
      Status status,
      String? errorMessage,
      bool saved});
}

/// @nodoc
class _$AddTaskStateCopyWithImpl<$Res, $Val extends AddTaskState>
    implements $AddTaskStateCopyWith<$Res> {
  _$AddTaskStateCopyWithImpl(this._value, this._then);

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
    Object? saved = null,
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
      saved: null == saved
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddTaskStateCopyWith<$Res>
    implements $AddTaskStateCopyWith<$Res> {
  factory _$$_AddTaskStateCopyWith(
          _$_AddTaskState value, $Res Function(_$_AddTaskState) then) =
      __$$_AddTaskStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CategoryModel> categories,
      Status status,
      String? errorMessage,
      bool saved});
}

/// @nodoc
class __$$_AddTaskStateCopyWithImpl<$Res>
    extends _$AddTaskStateCopyWithImpl<$Res, _$_AddTaskState>
    implements _$$_AddTaskStateCopyWith<$Res> {
  __$$_AddTaskStateCopyWithImpl(
      _$_AddTaskState _value, $Res Function(_$_AddTaskState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? saved = null,
  }) {
    return _then(_$_AddTaskState(
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
      saved: null == saved
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AddTaskState implements _AddTaskState {
  _$_AddTaskState(
      {final List<CategoryModel> categories = const [],
      this.status = Status.initial,
      this.errorMessage,
      this.saved = false})
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
  @JsonKey()
  final bool saved;

  @override
  String toString() {
    return 'AddTaskState(categories: $categories, status: $status, errorMessage: $errorMessage, saved: $saved)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddTaskState &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.saved, saved) || other.saved == saved));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      status,
      errorMessage,
      saved);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddTaskStateCopyWith<_$_AddTaskState> get copyWith =>
      __$$_AddTaskStateCopyWithImpl<_$_AddTaskState>(this, _$identity);
}

abstract class _AddTaskState implements AddTaskState {
  factory _AddTaskState(
      {final List<CategoryModel> categories,
      final Status status,
      final String? errorMessage,
      final bool saved}) = _$_AddTaskState;

  @override
  List<CategoryModel> get categories;
  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  bool get saved;
  @override
  @JsonKey(ignore: true)
  _$$_AddTaskStateCopyWith<_$_AddTaskState> get copyWith =>
      throw _privateConstructorUsedError;
}
