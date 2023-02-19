part of 'proba_cubit.dart';

class ProbaState {
  final String errorMessage;
  final String textNote;
  final bool saved;
  DateTime? releaseDate;
  String? selectedDateFormatted;
  TimeOfDay? releaseTime;
  final bool isLoading;
  final List<CategoryModel2> categories;
  Function(DateTime?)? onDateChanged;
  final DateTime? selectedDate;
  ProbaState({
    this.selectedDateFormatted,
    this.releaseTime,
    this.releaseDate,
    this.errorMessage = '',
    this.textNote = '',
    this.saved = false,
    this.categories = const [],
    this.isLoading = false,
    this.selectedDate,
  });
}
