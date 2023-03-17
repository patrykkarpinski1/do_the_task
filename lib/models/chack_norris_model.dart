class ChackNorrisModel {
  const ChackNorrisModel({
    required this.joke,
  });
  final String joke;
  ChackNorrisModel.fromJson(Map<String, dynamic> json) : joke = json['value'];
}
