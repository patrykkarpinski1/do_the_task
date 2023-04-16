import 'package:flutter/material.dart';
import '/models/photo_note_model.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    required this.photoNoteModel,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final PhotoNoteModel? photoNoteModel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {},
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
        child: Hero(
          tag: photoNoteModel?.id ?? 'Unkown',
          child: FadeInImage(
            placeholder: const AssetImage('images/loadnig.png'),
            image: NetworkImage(photoNoteModel?.photo ?? 'Unkown'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
