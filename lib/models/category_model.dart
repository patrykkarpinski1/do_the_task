class CategoryModel {
  final String title;
  final String id;
  final String? images;
  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        images = json['images'];

  CategoryModel({this.images, required this.id, required this.title});
}
