part of 'chack_norris_cubit.dart';

class ChackNorrisState {
  const ChackNorrisState({
    this.model,
    this.status = Status.initial,
    this.errorMessage,
  });
  final ChackNorrisModel? model;
  final Status status;
  final String? errorMessage;
}
