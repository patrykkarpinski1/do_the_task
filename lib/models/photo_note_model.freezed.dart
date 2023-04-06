// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_note_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PhotoNoteModel _$PhotoNoteModelFromJson(Map<String, dynamic> json) {
  return _PhotoNoteModel.fromJson(json);
}

/// @nodoc
mixin _$PhotoNoteModel {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo')
  String get photo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhotoNoteModelCopyWith<PhotoNoteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoNoteModelCopyWith<$Res> {
  factory $PhotoNoteModelCopyWith(
          PhotoNoteModel value, $Res Function(PhotoNoteModel) then) =
      _$PhotoNoteModelCopyWithImpl<$Res, PhotoNoteModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id, @JsonKey(name: 'photo') String photo});
}

/// @nodoc
class _$PhotoNoteModelCopyWithImpl<$Res, $Val extends PhotoNoteModel>
    implements $PhotoNoteModelCopyWith<$Res> {
  _$PhotoNoteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? photo = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      photo: null == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PhotoNoteModelCopyWith<$Res>
    implements $PhotoNoteModelCopyWith<$Res> {
  factory _$$_PhotoNoteModelCopyWith(
          _$_PhotoNoteModel value, $Res Function(_$_PhotoNoteModel) then) =
      __$$_PhotoNoteModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id, @JsonKey(name: 'photo') String photo});
}

/// @nodoc
class __$$_PhotoNoteModelCopyWithImpl<$Res>
    extends _$PhotoNoteModelCopyWithImpl<$Res, _$_PhotoNoteModel>
    implements _$$_PhotoNoteModelCopyWith<$Res> {
  __$$_PhotoNoteModelCopyWithImpl(
      _$_PhotoNoteModel _value, $Res Function(_$_PhotoNoteModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? photo = null,
  }) {
    return _then(_$_PhotoNoteModel(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PhotoNoteModel implements _PhotoNoteModel {
  _$_PhotoNoteModel(
      @JsonKey(name: 'id') this.id, @JsonKey(name: 'photo') this.photo);

  factory _$_PhotoNoteModel.fromJson(Map<String, dynamic> json) =>
      _$$_PhotoNoteModelFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'photo')
  final String photo;

  @override
  String toString() {
    return 'PhotoNoteModel(id: $id, photo: $photo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PhotoNoteModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.photo, photo) || other.photo == photo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, photo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PhotoNoteModelCopyWith<_$_PhotoNoteModel> get copyWith =>
      __$$_PhotoNoteModelCopyWithImpl<_$_PhotoNoteModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PhotoNoteModelToJson(
      this,
    );
  }
}

abstract class _PhotoNoteModel implements PhotoNoteModel {
  factory _PhotoNoteModel(@JsonKey(name: 'id') final String id,
      @JsonKey(name: 'photo') final String photo) = _$_PhotoNoteModel;

  factory _PhotoNoteModel.fromJson(Map<String, dynamic> json) =
      _$_PhotoNoteModel.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'photo')
  String get photo;
  @override
  @JsonKey(ignore: true)
  _$$_PhotoNoteModelCopyWith<_$_PhotoNoteModel> get copyWith =>
      throw _privateConstructorUsedError;
}
