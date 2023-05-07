import 'package:bloc_test/bloc_test.dart';
import 'package:do_the_task/app/core/enums.dart';
import 'package:do_the_task/features/home/pages/notepad/cubit/notepad_cubit.dart';
import 'package:do_the_task/models/note_model.dart';
import 'package:do_the_task/repositories/item_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

void main() {
  late NotepadCubit sut;
  late MockItemsRepository itemsRepository;
  final mockNotes = [
    NoteModel(note: 'note1', id: 'id1', releaseDate: DateTime.utc(2022)),
    NoteModel(note: 'note2', id: 'id2', releaseDate: DateTime.utc(2022)),
    NoteModel(note: 'note3', id: 'id3', releaseDate: DateTime.utc(2022)),
  ];

  setUp(() {
    itemsRepository = MockItemsRepository();
    sut = NotepadCubit(itemsRepository: itemsRepository);
  });

  group('start', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.getNotesStream())
            .thenAnswer((_) => Stream.value(mockNotes));
      });

      blocTest<NotepadCubit, NotepadState>(
        'emits Status.loading then Status.success with results',
        build: () => NotepadCubit(itemsRepository: itemsRepository),
        act: (cubit) => cubit.start(),
        expect: () => [
          NotepadState(
            status: Status.loading,
          ),
          NotepadState(
            status: Status.success,
            notes: mockNotes,
          ),
        ],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => itemsRepository.getNotesStream())
            .thenAnswer((_) => Stream.error('error: error'));
      });

      blocTest<NotepadCubit, NotepadState>(
        'emits Status.loading then Status.error with error message',
        build: () => NotepadCubit(itemsRepository: itemsRepository),
        act: (cubit) => cubit.start(),
        expect: () => [
          NotepadState(
            status: Status.loading,
          ),
          NotepadState(
            status: Status.error,
            errorMessage: 'error: error',
          ),
        ],
      );
    });
  });

  group('deleteNote', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.deleteNote(id: '1'))
            .thenAnswer((_) async => []);
      });
      blocTest<NotepadCubit, NotepadState>(
        'deletes a note with the specified id',
        build: () => sut,
        act: (cubit) => cubit.remove(documentID: '1'),
        expect: () => [],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.deleteNote(id: '1'))
            .thenThrow(Exception('test-exception-error'));
        when(() => itemsRepository.getNotesStream())
            .thenAnswer((_) => Stream.value(mockNotes));
      });
      blocTest<NotepadCubit, NotepadState>(
        'emits Status.error with an error message when deletion fails',
        build: () => sut,
        act: (cubit) => cubit.remove(documentID: '1'),
        expect: () => [
          NotepadState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
          NotepadState(
            status: Status.loading,
          ),
          NotepadState(
            status: Status.success,
            notes: mockNotes,
          ),
        ],
      );
    });
  });

  group('changetextNote', () {
    blocTest<NotepadCubit, NotepadState>(
        'emits a new state with the name of the note',
        build: () => sut,
        act: (cubit) => cubit.changetextNote('newTextNote'),
        expect: () => [
              NotepadState(textNote: 'newTextNote'),
            ]);
  });
  group('addNote', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.addNote('note', DateTime.utc(2022)))
            .thenAnswer((_) async => [
                  'note',
                  DateTime.utc(2022),
                ]);
      });
      blocTest<NotepadCubit, NotepadState>(
        'emits saved: true',
        build: () => sut,
        act: (cubit) => cubit.add('note', DateTime.utc(2022)),
        expect: () => [
          NotepadState(saved: true),
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.addNote('note', DateTime.utc(2022)))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<NotepadCubit, NotepadState>(
        'emits Status.error when saved fails',
        build: () => sut,
        act: (cubit) => cubit.add('note', DateTime.utc(2022)),
        expect: () => [
          NotepadState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
}
