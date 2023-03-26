class PhotoNoteModel {
  PhotoNoteModel({
    required this.id,
    required this.photo,
  });

  final String id;
  final String photo;
  PhotoNoteModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        photo = json['photo'];
}
