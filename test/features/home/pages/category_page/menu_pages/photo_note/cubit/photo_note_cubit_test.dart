import 'package:bloc_test/bloc_test.dart';
import 'package:do_the_task/app/core/enums.dart';
import 'package:do_the_task/features/home/pages/category_page/menu_pages/photo_note/cubit/photo_note_cubit.dart';
import 'package:do_the_task/models/photo_note_model.dart';
import 'package:do_the_task/repositories/item_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

void main() {
  late PhotoNoteCubit sut;
  late MockItemsRepository itemsRepository;

  setUp(() {
    itemsRepository = MockItemsRepository();
    sut = PhotoNoteCubit(itemsRepository: itemsRepository);
  });
  group('start', () {
    final mockPhotos = [
      PhotoNoteModel('id1', 'photo1'),
      PhotoNoteModel('id2', 'photo2'),
      PhotoNoteModel('id3', 'photo3'),
    ];
    group('success', () {
      setUp(() {
        when(() => itemsRepository.getPhotosStream())
            .thenAnswer((_) => Stream.value(mockPhotos));
      });
      blocTest<PhotoNoteCubit, PhotoNoteState>(
        'emits Status.loading then Status.success with results',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          PhotoNoteState(status: Status.loading),
          PhotoNoteState(status: Status.success, photos: mockPhotos)
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.getPhotosStream())
            .thenAnswer((_) => Stream.error('error: error'));
      });
      blocTest<PhotoNoteCubit, PhotoNoteState>(
        'emits Status.loading then Status.error with error message',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          PhotoNoteState(status: Status.loading),
          PhotoNoteState(
            status: Status.error,
            errorMessage: 'error: error',
          ),
        ],
      );
    });
  });

  group('add', () {
    final mockImage = XFile('image');
    group('success', () {
      setUp(() {
        when(() => itemsRepository.addPhotos(mockImage))
            .thenAnswer((_) async => mockImage);
      });
      blocTest<PhotoNoteCubit, PhotoNoteState>(
        'emits saved: true',
        build: () => sut,
        act: (cubit) => cubit.add(mockImage),
        expect: () => [
          PhotoNoteState(saved: true),
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.addPhotos(mockImage))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<PhotoNoteCubit, PhotoNoteState>(
        'emits Status.error when saved fails',
        build: () => sut,
        act: (cubit) => cubit.add(mockImage),
        expect: () => [
          PhotoNoteState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
}
