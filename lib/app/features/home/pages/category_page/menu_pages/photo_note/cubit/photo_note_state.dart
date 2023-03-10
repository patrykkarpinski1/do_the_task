part of 'photo_note_cubit.dart';

class PhotoNoteState {
  final List<PhotoNoteModel> photos;
  final bool removingErrorOccured;
  final Status status;
  final String? errorMessage;
  final bool saved;

  PhotoNoteState({
    this.photos = const [],
    this.removingErrorOccured = false,
    this.status = Status.initial,
    this.errorMessage = '',
    this.saved = false,
  });
}
