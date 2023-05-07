import 'package:do_the_task/data/remote_data_sources/items_remote_data_source.dart';
import 'package:do_the_task/models/note_model.dart';
import 'package:do_the_task/models/photo_note_model.dart';
import 'package:do_the_task/models/task_model.dart';
import 'package:do_the_task/repositories/item_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsDataSource extends Mock implements ItemsRemoteDataSources {}

void main() {
  late ItemsRepository sut;
  late MockItemsDataSource dataSource;
  setUp(() {
    dataSource = MockItemsDataSource();
    sut = ItemsRepository(itemsRemoteDataSources: dataSource);
  });

  group('getCategories', () {
    test('should call itemsRemoteDataSources.getCategories() method', () async {
      //1
      when(() => dataSource.getCategories()).thenAnswer((_) async => []);
      //2
      await sut.getCategories();
      //3
      verify(() => dataSource.getCategories()).called(1);
    });
  });
  group('getCategory', () {
    test('should call itemsRemoteDataSources.getCategory(categoryId) method',
        () async {
      final mockCategory = {
        'title': 'title1',
        'id': '1',
        'images': null,
      };
      // 1
      when(() => dataSource.getCategory(id: '1'))
          .thenAnswer((_) async => mockCategory);
      // 2
      final result = await sut.getCategory(id: '1');
      // 3
      expect(result.title, equals(mockCategory['title']));
      expect(result.id, equals(mockCategory['id']));
      expect(result.images, equals(mockCategory['images']));
      verify(() => dataSource.getCategory(id: '1'));
    });
  });
  group('addPhotos', () {
    final mockImage = XFile('test/image.jpg');

    test(
        'should call itemsRemoteDataSources.addPhotos() method with correct argument',
        () async {
      //1
      final expectedArgument = mockImage;
      when(() => dataSource.addPhotos(expectedArgument))
          .thenAnswer((_) => Future.value());
      //2
      await sut.addPhotos(mockImage);
      //3
      verify(() => dataSource.addPhotos(expectedArgument)).called(1);
    });
  });

  group('getPhotosStream', () {
    final mockPhotos = [
      PhotoNoteModel('id1', 'photo1'),
      PhotoNoteModel('id2', 'photo2'),
      PhotoNoteModel('id3', 'photo3'),
    ];
    test('should call itemsRemoteDataSources.getPhotosStream() method', () {
      //1
      when(() => dataSource.getPhotosStream())
          .thenAnswer((_) => Stream.value([]));
      //2
      sut.getPhotosStream();
      //3
      verify(() => dataSource.getPhotosStream()).called(1);
    });

    test('should return a list of PhotoNoteModel', () async {
      //4
      when(() => dataSource.getPhotosStream()).thenAnswer((_) => Stream.value(
          mockPhotos
              .map((photoNoteModel) => photoNoteModel.toJson())
              .toList()));
      //5
      final result = await sut.getPhotosStream().first;
      //6
      expect(result, isA<List<PhotoNoteModel>>());
      expect(result, mockPhotos);
    });
  });

  group('getTasks', () {
    test('should call itemsRemoteDataSources.getTasks(categoryId) method',
        () async {
      //1
      when(() => dataSource.getTasks(categoryId: '1'))
          .thenAnswer((_) async => []);
      //2
      await sut.getTasks(categoryId: '1');
      //3
      verify(() => dataSource.getTasks(categoryId: '1')).called(1);
    });
  });
  group('deleteTask', () {
    test(
        'should call itemsRemoteDataSources.deleteTask() method with correct argument',
        () async {
      const mockTaskId = '12';
      // 1
      when(() => dataSource.deleteTask(id: any(named: 'id')))
          .thenAnswer((_) => Future.value());
      // 2
      await sut.deleteTask(id: mockTaskId);
      // 3
      verify(() => dataSource.deleteTask(id: mockTaskId)).called(1);
    });
  });
  group('addTasks', () {
    const mockText = 'text';
    final mockReleaseDate = DateTime(2023, 4, 27);
    const mockReleaseTime = TimeOfDay(hour: 10, minute: 30);
    const mockCategoryId = '12';

    setUp(() {
      registerFallbackValue(const TimeOfDay(hour: 0, minute: 0));
    });

    test(
        'should call itemsRemoteDataSources.addTasks() method with correct arguments',
        () async {
      final expectedArguments = [
        mockText,
        mockReleaseDate,
        mockReleaseTime,
        mockCategoryId
      ];
      // 1
      when(() => dataSource.addTasks(any(), any(), any(), any()))
          .thenAnswer((_) => Future.value());
      // 2
      await sut.addTasks(
          mockText, mockReleaseDate, mockReleaseTime, mockCategoryId);
      // 3
      verify(() => dataSource.addTasks(
            expectedArguments[0] as String,
            expectedArguments[1] as DateTime,
            expectedArguments[2] as TimeOfDay,
            expectedArguments[3] as String,
          )).called(1);
    });
  });
  group('deleteNote', () {
    test(
        'should call itemsRemoteDataSources.deleteNote() method with correct argument',
        () async {
      const mockNoteId = '12';
      // 1
      when(() => dataSource.deleteNote(id: any(named: 'id')))
          .thenAnswer((_) => Future.value());
      // 2
      await sut.deleteNote(id: mockNoteId);
      // 3
      verify(() => dataSource.deleteNote(id: mockNoteId)).called(1);
    });
  });
  group('deletePhotoStorage', () {
    test(
        'should call itemsRemoteDataSources.deletePhotoStorage() method with correct argument',
        () async {
      const mockPhoto = 'photo';
      // 1
      when(() => dataSource.deletePhotoStorage(photo: any(named: 'photo')))
          .thenAnswer((_) => Future.value());
      // 2
      await sut.deletePhotoStorage(photo: mockPhoto);
      // 3
      verify(() => dataSource.deletePhotoStorage(photo: mockPhoto)).called(1);
    });
  });
  group('deletePhotoDocument', () {
    test(
        'should call itemsRemoteDataSources.deletePhotoDocument() method with correct argument',
        () async {
      const mockPhotoId = '12';
      // 1
      when(() => dataSource.deletePhotoDocument(id: any(named: 'id')))
          .thenAnswer((_) => Future.value());
      // 2
      await sut.deletePhotoDocument(id: mockPhotoId);
      // 3
      verify(() => dataSource.deletePhotoDocument(id: mockPhotoId)).called(1);
    });
  });
  group('addNote', () {
    const mockNote = 'note';
    final mockReleaseDate = DateTime(2023, 4, 27);

    test(
        'should call itemsRemoteDataSources.addNote() method with correct arguments',
        () async {
      final expectedArguments = [
        mockNote,
        mockReleaseDate,
      ];
      // 1
      when(() => dataSource.addNote(
            any(),
            any(),
          )).thenAnswer((_) => Future.value());
      // 2
      await sut.addNote(
        mockNote,
        mockReleaseDate,
      );
      // 3
      verify(() => dataSource.addNote(
            expectedArguments[0] as String,
            expectedArguments[1] as DateTime,
          )).called(1);
    });
  });
  group('getDetailsTask', () {
    test('should call itemsRemoteDataSources.getDetailsTask(id) method',
        () async {
      final mockTask = TaskModel(
        text: 'text',
        id: '1',
        categoryId: '1',
        releaseDate: DateTime.utc(2022),
      );
      // 1
      when(() => dataSource.getDetalisTask(id: '1'))
          .thenAnswer((_) async => mockTask.toJson());
      // 2
      final result = await sut.getDetalisTask(id: '1');
      // 3
      expect(result.text, equals(mockTask.text));
      expect(result.id, equals(mockTask.id));
      expect(result.categoryId, equals(mockTask.categoryId));
      expect(result.releaseDate.toUtc(), equals(mockTask.releaseDate.toUtc()));
      verify(() => dataSource.getDetalisTask(id: '1'));
    });
  });
  group('getDetalisNote', () {
    test('should call itemsRemoteDataSources.getDetalisNote(id) method',
        () async {
      final mockNote = NoteModel(
        note: 'note',
        id: '1',
        releaseDate: DateTime.utc(2022),
      );
      // 1
      when(() => dataSource.getDetalisNote(id: '1'))
          .thenAnswer((_) async => mockNote.toJson());
      // 2
      final result = await sut.getDetalisNote(id: '1');
      // 3
      expect(result.note, equals(mockNote.note));
      expect(result.id, equals(mockNote.id));
      expect(result.releaseDate.toUtc(), equals(mockNote.releaseDate.toUtc()));
      verify(() => dataSource.getDetalisNote(id: '1'));
    });
  });
  group('editNote', () {
    test(
        'should call editNote method on remote data source with correct values',
        () async {
      // 1
      const id = '123';
      const note = 'New note';
      when(() => dataSource.editNote(
            id: any(named: 'id'),
            note: any(named: 'note'),
          )).thenAnswer((_) async {});
      // 2
      await sut.editNote(
        id: id,
        note: note,
      );
      // 3
      verify(() => dataSource.editNote(
            id: id,
            note: note,
          )).called(1);
    });
  });
  group('getDetalisPhotoNote', () {
    test('should call itemsRemoteDataSources.getDetalisPhotoNote(id) method',
        () async {
      final mockPhotoNote = PhotoNoteModel('id', 'photo');
      // 1
      when(() => dataSource.getDetalisPhotoNote(id: '1'))
          .thenAnswer((_) async => mockPhotoNote.toJson());
      // 2
      final result = await sut.getDetalisPhotoNote(id: '1');
      // 3
      expect(result.id, equals(mockPhotoNote.id));
      verify(() => dataSource.getDetalisPhotoNote(id: '1'));
    });
  });
  group('getNotesStream', () {
    final mockNotes = [
      NoteModel(
        note: 'note1',
        id: '1',
        releaseDate: DateTime(2023, 4, 27),
      ),
      NoteModel(
        note: 'note2',
        id: '2',
        releaseDate: DateTime(2023, 4, 27),
      ),
      NoteModel(
        note: 'note3',
        id: '3',
        releaseDate: DateTime(2023, 4, 27),
      ),
    ];
    test('should call itemsRemoteDataSources.getNotesStream() method', () {
      //1
      when(() => dataSource.getNotesStream())
          .thenAnswer((_) => Stream.value([]));
      //2
      sut.getNotesStream();
      //3
      verify(() => dataSource.getNotesStream()).called(1);
    });

    test('should return a list of NoteModel', () async {
      //4
      when(() => dataSource.getNotesStream()).thenAnswer((_) => Stream.value(
          mockNotes.map((noteModel) => noteModel.toJson()).toList()));
      //5
      final result = await sut.getNotesStream().first;
      //6
      expect(result, isA<List<NoteModel>>());
      expect(result, mockNotes);
    });
  });
}
