part of 'auth_cubit.dart';

@immutable
class AuthState {
  final User? user;
  final String errorMessage;
  final Status status;
  final bool isCreatingAccount;
  final String message;

  const AuthState({
    this.user,
    this.status = Status.initial,
    this.errorMessage = '',
    this.isCreatingAccount = false,
    this.message = '',
  });
}
