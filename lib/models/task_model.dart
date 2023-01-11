class TaskModel {
  TaskModel(
      {required this.note,
      required this.title,
      required this.text,
      required this.releaseDate});
  final String note;
  final String title;
  final String text;
  final DateTime releaseDate;
}
