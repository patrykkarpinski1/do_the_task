// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detalis_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DetalisState {
  TaskModel? get taskModel => throw _privateConstructorUsedError;
  PhotoNoteModel? get photoNoteModel => throw _privateConstructorUsedError;
  NoteModel? get noteModel => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DetalisStateCopyWith<DetalisState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetalisStateCopyWith<$Res> {
  factory $DetalisStateCopyWith(
          DetalisState value, $Res Function(DetalisState) then) =
      _$DetalisStateCopyWithImpl<$Res, DetalisState>;
  @useResult
  $Res call(
      {TaskModel? taskModel,
      PhotoNoteModel? photoNoteModel,
      NoteModel? noteModel,
      Status status,
      String? errorMessage});

  $TaskModelCopyWith<$Res>? get taskModel;
  $PhotoNoteModelCopyWith<$Res>? get photoNoteModel;
  $NoteModelCopyWith<$Res>? get noteModel;
}

/// @nodoc
class _$DetalisStateCopyWithImpl<$Res, $Val extends DetalisState>
    implements $DetalisStateCopyWith<$Res> {
  _$DetalisStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskModel = freezed,
    Object? photoNoteModel = freezed,
    Object? noteModel = freezed,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      taskModel: freezed == taskModel
          ? _value.taskModel
          : taskModel // ignore: cast_nullable_to_non_nullable
              as TaskModel?,
      photoNoteModel: freezed == photoNoteModel
          ? _value.photoNoteModel
          : photoNoteModel // ignore: cast_nullable_to_non_nullable
              as PhotoNoteModel?,
      noteModel: freezed == noteModel
          ? _value.noteModel
          : noteModel // ignore: cast_nullable_to_non_nullable
              as NoteModel?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskModelCopyWith<$Res>? get taskModel {
    if (_value.taskModel == null) {
      return null;
    }

    return $TaskModelCopyWith<$Res>(_value.taskModel!, (value) {
      return _then(_value.copyWith(taskModel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PhotoNoteModelCopyWith<$Res>? get photoNoteModel {
    if (_value.photoNoteModel == null) {
      return null;
    }

    return $PhotoNoteModelCopyWith<$Res>(_value.photoNoteModel!, (value) {
      return _then(_value.copyWith(photoNoteModel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NoteModelCopyWith<$Res>? get noteModel {
    if (_value.noteModel == null) {
      return null;
    }

    return $NoteModelCopyWith<$Res>(_value.noteModel!, (value) {
      return _then(_value.copyWith(noteModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DetalisStateCopyWith<$Res>
    implements $DetalisStateCopyWith<$Res> {
  factory _$$_DetalisStateCopyWith(
          _$_DetalisState value, $Res Function(_$_DetalisState) then) =
      __$$_DetalisStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TaskModel? taskModel,
      PhotoNoteModel? photoNoteModel,
      NoteModel? noteModel,
      Status status,
      String? errorMessage});

  @override
  $TaskModelCopyWith<$Res>? get taskModel;
  @override
  $PhotoNoteModelCopyWith<$Res>? get photoNoteModel;
  @override
  $NoteModelCopyWith<$Res>? get noteModel;
}

/// @nodoc
class __$$_DetalisStateCopyWithImpl<$Res>
    extends _$DetalisStateCopyWithImpl<$Res, _$_DetalisState>
    implements _$$_DetalisStateCopyWith<$Res> {
  __$$_DetalisStateCopyWithImpl(
      _$_DetalisState _value, $Res Function(_$_DetalisState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskModel = freezed,
    Object? photoNoteModel = freezed,
    Object? noteModel = freezed,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_DetalisState(
      taskModel: freezed == taskModel
          ? _value.taskModel
          : taskModel // ignore: cast_nullable_to_non_nullable
              as TaskModel?,
      photoNoteModel: freezed == photoNoteModel
          ? _value.photoNoteModel
          : photoNoteModel // ignore: cast_nullable_to_non_nullable
              as PhotoNoteModel?,
      noteModel: freezed == noteModel
          ? _value.noteModel
          : noteModel // ignore: cast_nullable_to_non_nullable
              as NoteModel?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_DetalisState implements _DetalisState {
  _$_DetalisState(
      {this.taskModel,
      this.photoNoteModel,
      this.noteModel,
      this.status = Status.initial,
      this.errorMessage});

  @override
  final TaskModel? taskModel;
  @override
  final PhotoNoteModel? photoNoteModel;
  @override
  final NoteModel? noteModel;
  @override
  @JsonKey()
  final Status status;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'DetalisState(taskModel: $taskModel, photoNoteModel: $photoNoteModel, noteModel: $noteModel, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DetalisState &&
            (identical(other.taskModel, taskModel) ||
                other.taskModel == taskModel) &&
            (identical(other.photoNoteModel, photoNoteModel) ||
                other.photoNoteModel == photoNoteModel) &&
            (identical(other.noteModel, noteModel) ||
                other.noteModel == noteModel) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, taskModel, photoNoteModel, noteModel, status, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DetalisStateCopyWith<_$_DetalisState> get copyWith =>
      __$$_DetalisStateCopyWithImpl<_$_DetalisState>(this, _$identity);
}

abstract class _DetalisState implements DetalisState {
  factory _DetalisState(
      {final TaskModel? taskModel,
      final PhotoNoteModel? photoNoteModel,
      final NoteModel? noteModel,
      final Status status,
      final String? errorMessage}) = _$_DetalisState;

  @override
  TaskModel? get taskModel;
  @override
  PhotoNoteModel? get photoNoteModel;
  @override
  NoteModel? get noteModel;
  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_DetalisStateCopyWith<_$_DetalisState> get copyWith =>
      throw _privateConstructorUsedError;
}
