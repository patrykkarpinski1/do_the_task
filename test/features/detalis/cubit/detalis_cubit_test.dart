import 'package:bloc_test/bloc_test.dart';
import 'package:do_the_task/app/core/enums.dart';
import 'package:do_the_task/features/detalis/cubit/detalis_cubit.dart';
import 'package:do_the_task/models/note_model.dart';
import 'package:do_the_task/models/photo_note_model.dart';
import 'package:do_the_task/models/task_model.dart';
import 'package:do_the_task/repositories/item_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

void main() {
  late DetalisCubit sut;
  late MockItemsRepository itemsRepository;

  setUp(() {
    itemsRepository = MockItemsRepository();
    sut = DetalisCubit(itemsRepository: itemsRepository);
  });
  group('getTaskWithID', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.getDetalisTask(id: '1')).thenAnswer(
          (_) async => TaskModel(
            text: 'text',
            id: 'id',
            categoryId: '1',
            releaseDate: DateTime.utc(2022),
          ),
        );
      });
      blocTest<DetalisCubit, DetalisState>(
        'emits Status.loading then Status.success with results',
        build: () => sut,
        act: (cubit) => cubit.getTaskWithID('1'),
        expect: () => [
          DetalisState(
            status: Status.loading,
            taskModel: null,
          ),
          DetalisState(
            status: Status.success,
            taskModel: TaskModel(
              text: 'text',
              id: 'id',
              categoryId: '1',
              releaseDate: DateTime.utc(2022),
            ),
          )
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.getDetalisTask(id: '1'))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<DetalisCubit, DetalisState>(
        'emits Status.loading then Status.error with error message',
        build: () => sut,
        act: (cubit) => cubit.getTaskWithID('1'),
        expect: () => [
          DetalisState(
            status: Status.loading,
            taskModel: null,
          ),
          DetalisState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
  group('getPhotoWithID', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.getDetalisPhotoNote(id: '1')).thenAnswer(
          (_) async => PhotoNoteModel('id1', 'photo1'),
        );
      });
      blocTest<DetalisCubit, DetalisState>(
        'emits Status.loading then Status.success with results',
        build: () => sut,
        act: (cubit) => cubit.getPhotoWithID('1'),
        expect: () => [
          DetalisState(
            status: Status.loading,
            photoNoteModel: null,
          ),
          DetalisState(
            status: Status.success,
            photoNoteModel: PhotoNoteModel('id1', 'photo1'),
          )
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.getDetalisPhotoNote(id: '1'))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<DetalisCubit, DetalisState>(
        'emits Status.loading then Status.error with error message',
        build: () => sut,
        act: (cubit) => cubit.getPhotoWithID('1'),
        expect: () => [
          DetalisState(
            status: Status.loading,
            photoNoteModel: null,
          ),
          DetalisState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
  group('removePhotoStorage', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.deletePhotoStorage(photo: 'photo'))
            .thenAnswer((_) async => []);
      });
      blocTest<DetalisCubit, DetalisState>(
        'deletes a photo with the specified id',
        build: () => sut,
        act: (cubit) => cubit.removePhotoStorage(photo: 'photo'),
        expect: () => [],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.deletePhotoStorage(photo: 'photo'))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<DetalisCubit, DetalisState>(
        'emits Status.error with an error message when deletion fails',
        build: () => sut,
        act: (cubit) => cubit.removePhotoStorage(photo: 'photo'),
        expect: () => [
          DetalisState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
  group('removePhotoDocument', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.deletePhotoDocument(id: '1'))
            .thenAnswer((_) async => []);
      });
      blocTest<DetalisCubit, DetalisState>(
        'deletes a photo document with the specified id',
        build: () => sut,
        act: (cubit) => cubit.removePhotoDocument(documentID: '1'),
        expect: () => [],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.deletePhotoDocument(id: '1'))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<DetalisCubit, DetalisState>(
        'emits Status.error with an error message when deletion fails',
        build: () => sut,
        act: (cubit) => cubit.removePhotoDocument(documentID: '1'),
        expect: () => [
          DetalisState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });

  group('getNoteWithID', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.getDetalisNote(id: '1')).thenAnswer(
          (_) async => NoteModel(
              note: 'note1', id: 'id1', releaseDate: DateTime.utc(2022)),
        );
      });
      blocTest<DetalisCubit, DetalisState>(
        'emits Status.loading then Status.success with results',
        build: () => sut,
        act: (cubit) => cubit.getNoteWithID('1'),
        expect: () => [
          DetalisState(
            status: Status.loading,
            noteModel: null,
          ),
          DetalisState(
            status: Status.success,
            noteModel: NoteModel(
                note: 'note1', id: 'id1', releaseDate: DateTime.utc(2022)),
          )
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.getDetalisNote(id: '1'))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<DetalisCubit, DetalisState>(
        'emits Status.loading then Status.error with error message',
        build: () => sut,
        act: (cubit) => cubit.getNoteWithID('1'),
        expect: () => [
          DetalisState(
            status: Status.loading,
            noteModel: null,
          ),
          DetalisState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
  group('editNote', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.editNote(
                id: '12345', note: 'Updated note text'))
            .thenAnswer((_) async => NoteModel(
                id: '12345',
                note: 'Updated note text',
                releaseDate: DateTime.utc(2022)));
      });

      blocTest<DetalisCubit, DetalisState>(
        'should emit loading and NoteEdited states when repository call is successful',
        build: () => sut,
        act: (cubit) => cubit.editNote(
          documentID: '12345',
          note: 'Updated note text',
        ),
        expect: () => [],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => itemsRepository.editNote(
                id: '12345', note: 'Updated note text'))
            .thenAnswer((_) => throw Exception('test-exception-error'));
      });

      blocTest<DetalisCubit, DetalisState>(
        'should emit loading and error states with error message when repository call fails',
        build: () => sut,
        act: (cubit) => cubit.editNote(
          documentID: '12345',
          note: 'Updated note text',
        ),
        expect: () => [
          DetalisState(
            status: Status.error,
            errorMessage: 'Exception: test-exception-error',
          ),
        ],
      );
    });
  });
}
