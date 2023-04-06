// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notepad_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NotepadState {
  List<NoteModel> get notes => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get saved => throw _privateConstructorUsedError;
  String get textNote => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotepadStateCopyWith<NotepadState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotepadStateCopyWith<$Res> {
  factory $NotepadStateCopyWith(
          NotepadState value, $Res Function(NotepadState) then) =
      _$NotepadStateCopyWithImpl<$Res, NotepadState>;
  @useResult
  $Res call(
      {List<NoteModel> notes,
      Status status,
      String? errorMessage,
      bool saved,
      String textNote});
}

/// @nodoc
class _$NotepadStateCopyWithImpl<$Res, $Val extends NotepadState>
    implements $NotepadStateCopyWith<$Res> {
  _$NotepadStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? saved = null,
    Object? textNote = null,
  }) {
    return _then(_value.copyWith(
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
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
      textNote: null == textNote
          ? _value.textNote
          : textNote // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NotepadStateCopyWith<$Res>
    implements $NotepadStateCopyWith<$Res> {
  factory _$$_NotepadStateCopyWith(
          _$_NotepadState value, $Res Function(_$_NotepadState) then) =
      __$$_NotepadStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<NoteModel> notes,
      Status status,
      String? errorMessage,
      bool saved,
      String textNote});
}

/// @nodoc
class __$$_NotepadStateCopyWithImpl<$Res>
    extends _$NotepadStateCopyWithImpl<$Res, _$_NotepadState>
    implements _$$_NotepadStateCopyWith<$Res> {
  __$$_NotepadStateCopyWithImpl(
      _$_NotepadState _value, $Res Function(_$_NotepadState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? saved = null,
    Object? textNote = null,
  }) {
    return _then(_$_NotepadState(
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
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
      textNote: null == textNote
          ? _value.textNote
          : textNote // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_NotepadState implements _NotepadState {
  _$_NotepadState(
      {final List<NoteModel> notes = const [],
      this.status = Status.initial,
      this.errorMessage,
      this.saved = false,
      this.textNote = ''})
      : _notes = notes;

  final List<NoteModel> _notes;
  @override
  @JsonKey()
  List<NoteModel> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
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
  @JsonKey()
  final String textNote;

  @override
  String toString() {
    return 'NotepadState(notes: $notes, status: $status, errorMessage: $errorMessage, saved: $saved, textNote: $textNote)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotepadState &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.saved, saved) || other.saved == saved) &&
            (identical(other.textNote, textNote) ||
                other.textNote == textNote));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_notes),
      status,
      errorMessage,
      saved,
      textNote);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NotepadStateCopyWith<_$_NotepadState> get copyWith =>
      __$$_NotepadStateCopyWithImpl<_$_NotepadState>(this, _$identity);
}

abstract class _NotepadState implements NotepadState {
  factory _NotepadState(
      {final List<NoteModel> notes,
      final Status status,
      final String? errorMessage,
      final bool saved,
      final String textNote}) = _$_NotepadState;

  @override
  List<NoteModel> get notes;
  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  bool get saved;
  @override
  String get textNote;
  @override
  @JsonKey(ignore: true)
  _$$_NotepadStateCopyWith<_$_NotepadState> get copyWith =>
      throw _privateConstructorUsedError;
}
