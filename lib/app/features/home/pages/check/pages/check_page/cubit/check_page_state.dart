part of 'check_page_cubit.dart';

@immutable
class CheckPageState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;

  const CheckPageState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}
