import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modyfikacja_aplikacja/data/remote_data_sources/items_remote_data_source.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/models/note_model.dart';
import 'package:modyfikacja_aplikacja/models/photo_note_model.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';

class ItemsRepository {
  ItemsRepository(this.itemsRemoteDataSources);
  final ItemsRemoteDataSources itemsRemoteDataSources;

  Future<List<CategoryModel>> getCategories() async {
    final categories = await itemsRemoteDataSources.getCategories();
    return categories.map((json) {
      return CategoryModel.fromJson(json);
    }).toList();
  }

  Future<CategoryModel> getCategory({required String id}) async {
    final json = await itemsRemoteDataSources.getCategory(id: id);
    return CategoryModel.fromJson(json);
  }

  Future<void> addPhotos(
    XFile image,
  ) async {
    return itemsRemoteDataSources.addPhotos(image);
  }

  Stream<List<PhotoNoteModel>> getPhotosStream() {
    final photos = itemsRemoteDataSources.getPhotosStream();
    return photos.map((jsonList) {
      return jsonList.map((json) => PhotoNoteModel.fromJson(json)).toList();
    });
  }

  Future<List<TaskModel>> getTasks({
    required String categoryId,
  }) async {
    final tasks = await itemsRemoteDataSources.getTasks(categoryId: categoryId);
    return tasks.map((json) {
      return TaskModel.fromJson(json);
    }).toList();
  }

  Future<void> deleteTask({required String id}) async {
    return itemsRemoteDataSources.deleteTask(id: id);
  }

  Future<void> addTasks(
    String text,
    DateTime releaseDate,
    TimeOfDay releaseTime,
    String categoryId,
  ) async {
    return itemsRemoteDataSources.addTasks(
        text, releaseDate, releaseTime, categoryId);
  }

  Future<void> deleteNote({required String id}) {
    return itemsRemoteDataSources.deleteNote(id: id);
  }

  Future<void> deletePhotoStorage({
    required String photo,
  }) async {
    return itemsRemoteDataSources.deletePhotoStorage(photo: photo);
  }

  Future<void> deletePhotoDocument({
    required String id,
  }) async {
    return itemsRemoteDataSources.deletePhotoDocument(
      id: id,
    );
  }

  Future<void> addNote(
    String note,
    DateTime releaseDate,
  ) async {
    return itemsRemoteDataSources.addNote(note, releaseDate);
  }

  Future<TaskModel> getDetalisTask({required String id}) async {
    final json = await itemsRemoteDataSources.getDetalisTask(id: id);
    return TaskModel.fromJson(json);
  }

  Future<NoteModel> getDetalisNote({required String id}) async {
    final json = await itemsRemoteDataSources.getDetalisNote(id: id);
    return NoteModel.fromJson(json);
  }

  Future<void> editNote({
    required String id,
    required String note,
  }) async {
    return itemsRemoteDataSources.editNote(id: id, note: note);
  }

  Future<PhotoNoteModel> getDetalisPhotoNote({required String id}) async {
    final json = await itemsRemoteDataSources.getDetalisPhotoNote(id: id);
    return PhotoNoteModel.fromJson(json);
  }

  Stream<List<NoteModel>> getNotesStream() {
    final notes = itemsRemoteDataSources.getNotesStream();
    return notes.map((jsonList) {
      return jsonList.map((json) => NoteModel.fromJson(json)).toList();
    });
  }
}
