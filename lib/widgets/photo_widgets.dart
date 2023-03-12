import 'package:flutter/material.dart';
import 'package:modyfikacja_aplikacja/app/features/detalis/pages/detalis_photo_note.dart';
import 'package:modyfikacja_aplikacja/models/photo_note_model.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    required this.photoNoteModel,
    Key? key,
  }) : super(key: key);
  final PhotoNoteModel? photoNoteModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {},
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => DetalisPhotoNotePage(id: photoNoteModel!.id)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                photoNoteModel!.photo,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
