// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_note_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PhotoNoteState {
  List<PhotoNoteModel> get photos => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get saved => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PhotoNoteStateCopyWith<PhotoNoteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoNoteStateCopyWith<$Res> {
  factory $PhotoNoteStateCopyWith(
          PhotoNoteState value, $Res Function(PhotoNoteState) then) =
      _$PhotoNoteStateCopyWithImpl<$Res, PhotoNoteState>;
  @useResult
  $Res call(
      {List<PhotoNoteModel> photos,
      Status status,
      String? errorMessage,
      bool saved});
}

/// @nodoc
class _$PhotoNoteStateCopyWithImpl<$Res, $Val extends PhotoNoteState>
    implements $PhotoNoteStateCopyWith<$Res> {
  _$PhotoNoteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photos = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? saved = null,
  }) {
    return _then(_value.copyWith(
      photos: null == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<PhotoNoteModel>,
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
abstract class _$$_PhotoNoteStateCopyWith<$Res>
    implements $PhotoNoteStateCopyWith<$Res> {
  factory _$$_PhotoNoteStateCopyWith(
          _$_PhotoNoteState value, $Res Function(_$_PhotoNoteState) then) =
      __$$_PhotoNoteStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PhotoNoteModel> photos,
      Status status,
      String? errorMessage,
      bool saved});
}

/// @nodoc
class __$$_PhotoNoteStateCopyWithImpl<$Res>
    extends _$PhotoNoteStateCopyWithImpl<$Res, _$_PhotoNoteState>
    implements _$$_PhotoNoteStateCopyWith<$Res> {
  __$$_PhotoNoteStateCopyWithImpl(
      _$_PhotoNoteState _value, $Res Function(_$_PhotoNoteState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photos = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? saved = null,
  }) {
    return _then(_$_PhotoNoteState(
      photos: null == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<PhotoNoteModel>,
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

class _$_PhotoNoteState implements _PhotoNoteState {
  _$_PhotoNoteState(
      {final List<PhotoNoteModel> photos = const [],
      this.status = Status.initial,
      this.errorMessage,
      this.saved = false})
      : _photos = photos;

  final List<PhotoNoteModel> _photos;
  @override
  @JsonKey()
  List<PhotoNoteModel> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
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
    return 'PhotoNoteState(photos: $photos, status: $status, errorMessage: $errorMessage, saved: $saved)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PhotoNoteState &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.saved, saved) || other.saved == saved));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_photos),
      status,
      errorMessage,
      saved);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PhotoNoteStateCopyWith<_$_PhotoNoteState> get copyWith =>
      __$$_PhotoNoteStateCopyWithImpl<_$_PhotoNoteState>(this, _$identity);
}

abstract class _PhotoNoteState implements PhotoNoteState {
  factory _PhotoNoteState(
      {final List<PhotoNoteModel> photos,
      final Status status,
      final String? errorMessage,
      final bool saved}) = _$_PhotoNoteState;

  @override
  List<PhotoNoteModel> get photos;
  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  bool get saved;
  @override
  @JsonKey(ignore: true)
  _$$_PhotoNoteStateCopyWith<_$_PhotoNoteState> get copyWith =>
      throw _privateConstructorUsedError;
}
