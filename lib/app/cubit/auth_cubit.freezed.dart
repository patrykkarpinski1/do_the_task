// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  User? get user => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  bool get isCreatingAccount => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  bool get notificationsEnabled => throw _privateConstructorUsedError;
  bool get isAppOpenedViaNotification => throw _privateConstructorUsedError;
  String? get taskId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call(
      {User? user,
      Status status,
      bool isCreatingAccount,
      String errorMessage,
      String message,
      bool notificationsEnabled,
      bool isAppOpenedViaNotification,
      String? taskId});
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? status = null,
    Object? isCreatingAccount = null,
    Object? errorMessage = null,
    Object? message = null,
    Object? notificationsEnabled = null,
    Object? isAppOpenedViaNotification = null,
    Object? taskId = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      isCreatingAccount: null == isCreatingAccount
          ? _value.isCreatingAccount
          : isCreatingAccount // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isAppOpenedViaNotification: null == isAppOpenedViaNotification
          ? _value.isAppOpenedViaNotification
          : isAppOpenedViaNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$$_AuthStateCopyWith(
          _$_AuthState value, $Res Function(_$_AuthState) then) =
      __$$_AuthStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {User? user,
      Status status,
      bool isCreatingAccount,
      String errorMessage,
      String message,
      bool notificationsEnabled,
      bool isAppOpenedViaNotification,
      String? taskId});
}

/// @nodoc
class __$$_AuthStateCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_AuthState>
    implements _$$_AuthStateCopyWith<$Res> {
  __$$_AuthStateCopyWithImpl(
      _$_AuthState _value, $Res Function(_$_AuthState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? status = null,
    Object? isCreatingAccount = null,
    Object? errorMessage = null,
    Object? message = null,
    Object? notificationsEnabled = null,
    Object? isAppOpenedViaNotification = null,
    Object? taskId = freezed,
  }) {
    return _then(_$_AuthState(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      isCreatingAccount: null == isCreatingAccount
          ? _value.isCreatingAccount
          : isCreatingAccount // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isAppOpenedViaNotification: null == isAppOpenedViaNotification
          ? _value.isAppOpenedViaNotification
          : isAppOpenedViaNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AuthState implements _AuthState {
  const _$_AuthState(
      {this.user,
      this.status = Status.initial,
      this.isCreatingAccount = false,
      this.errorMessage = '',
      this.message = '',
      this.notificationsEnabled = true,
      this.isAppOpenedViaNotification = true,
      this.taskId});

  @override
  final User? user;
  @override
  @JsonKey()
  final Status status;
  @override
  @JsonKey()
  final bool isCreatingAccount;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final bool notificationsEnabled;
  @override
  @JsonKey()
  final bool isAppOpenedViaNotification;
  @override
  final String? taskId;

  @override
  String toString() {
    return 'AuthState(user: $user, status: $status, isCreatingAccount: $isCreatingAccount, errorMessage: $errorMessage, message: $message, notificationsEnabled: $notificationsEnabled, isAppOpenedViaNotification: $isAppOpenedViaNotification, taskId: $taskId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthState &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isCreatingAccount, isCreatingAccount) ||
                other.isCreatingAccount == isCreatingAccount) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.isAppOpenedViaNotification,
                    isAppOpenedViaNotification) ||
                other.isAppOpenedViaNotification ==
                    isAppOpenedViaNotification) &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      user,
      status,
      isCreatingAccount,
      errorMessage,
      message,
      notificationsEnabled,
      isAppOpenedViaNotification,
      taskId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthStateCopyWith<_$_AuthState> get copyWith =>
      __$$_AuthStateCopyWithImpl<_$_AuthState>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState(
      {final User? user,
      final Status status,
      final bool isCreatingAccount,
      final String errorMessage,
      final String message,
      final bool notificationsEnabled,
      final bool isAppOpenedViaNotification,
      final String? taskId}) = _$_AuthState;

  @override
  User? get user;
  @override
  Status get status;
  @override
  bool get isCreatingAccount;
  @override
  String get errorMessage;
  @override
  String get message;
  @override
  bool get notificationsEnabled;
  @override
  bool get isAppOpenedViaNotification;
  @override
  String? get taskId;
  @override
  @JsonKey(ignore: true)
  _$$_AuthStateCopyWith<_$_AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}
