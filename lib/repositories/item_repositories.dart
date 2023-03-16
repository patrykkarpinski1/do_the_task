import 'package:firebase_auth/firebase_auth.dart';
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
    return itemsRemoteDataSources.getCategories();
  }

  Future<CategoryModel> getCategory({required String id}) async {
    return itemsRemoteDataSources.getCategory(id: id);
  }

  Future<void> addPhotos(
    XFile image,
  ) async {
    return itemsRemoteDataSources.addPhotos(image);
  }

  Future<List<PhotoNoteModel>> getPhotos() async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return itemsRemoteDataSources.getPhotos();
  }

  Future<List<TaskModel>> getTasks({
    required String categoryId,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return itemsRemoteDataSources.getTasks(categoryId: categoryId);
  }

  Future<void> deleteTask({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return itemsRemoteDataSources.deleteTask(id: id);
  }

  Future<void> addTasks(
    String text,
    DateTime releaseDate,
    TimeOfDay releaseTime,
    String categoryId,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return itemsRemoteDataSources.addTasks(
        text, releaseDate, releaseTime, categoryId);
  }

  Stream<List<NoteModel>> getNotesStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return itemsRemoteDataSources.getNotesStream();
  }

  Future<void> deleteNote({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return itemsRemoteDataSources.deleteNote(id: id);
  }

  Future<void> deletePhoto({
    required String id,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }

    return itemsRemoteDataSources.deleteNote(id: id);
  }

  Future<void> addNote(
    String note,
    DateTime releaseDate,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }

    return itemsRemoteDataSources.addNote(note, releaseDate);
  }

  Future<TaskModel> getDetalisTask({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return itemsRemoteDataSources.getDetalisTask(id: id);
  }

  Future<NoteModel> getDetalisNote({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return itemsRemoteDataSources.getDetalisNote(id: id);
  }

  Future<PhotoNoteModel> getDetalisPhotoNote({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return itemsRemoteDataSources.getDetalisPhotoNote(id: id);
  }
}
