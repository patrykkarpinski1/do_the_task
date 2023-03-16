import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/models/note_model.dart';
import 'package:modyfikacja_aplikacja/models/photo_note_model.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class ItemsRemoteDataSources {
  Future<List<CategoryModel>> getCategories() async {
    final doc = await FirebaseFirestore.instance.collection('categories').get();

    return doc.docs.map((doc) {
      return (CategoryModel(
        id: doc.id,
        title: doc['title'],
        images: doc['images'],
      ));
    }).toList();
  }

  Future<CategoryModel> getCategory({required String id}) async {
    final doc =
        await FirebaseFirestore.instance.collection('categories').doc(id).get();
    return CategoryModel(
      id: doc.id,
      title: doc['title'],
    );
  }

  Future<void> addPhotos(
    XFile image,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final ref = FirebaseStorage.instance
        .ref()
        .child('photo_note')
        .child(path.basename(image.path));
    await ref.putFile(File(image.path));
    final url = await ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photo_note')
        .add({'photo': url});
  }

  Future<List<PhotoNoteModel>> getPhotos() async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photo_note')
        .get();

    return doc.docs.map((doc) {
      return PhotoNoteModel(
        id: doc.id,
        photo: doc['photo'],
      );
    }).toList();
  }

  Future<List<TaskModel>> getTasks({
    required String categoryId,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .orderBy('date')
        .where('category_id', isEqualTo: categoryId)
        .get();

    return doc.docs.map((doc) {
      return (TaskModel(
        id: doc.id,
        text: doc['text'],
        releaseDate: (doc['date'] as Timestamp).toDate(),
        categoryId: doc['category_id'],
      ));
    }).toList();
  }

  Future<void> deleteTask({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .doc(id)
        .delete();
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
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .add({
      'text': text,
      'category_id': categoryId,
      'date': DateTime(
        releaseDate.year,
        releaseDate.month,
        releaseDate.day,
        releaseTime.hour,
        releaseTime.minute,
      ),
    });
  }

  Stream<List<NoteModel>> getNotesStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notepad')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return NoteModel(
          note: doc['note'],
          id: doc.id,
          releaseDate: (doc['date'] as Timestamp).toDate(),
        );
      }).toList();
    });
  }

  Future<void> deleteNote({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notepad')
        .doc(id)
        .delete();
  }

  Future<void> deletePhoto({
    required String id,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photo_note')
        .doc(id)
        .delete();
  }

  Future<void> addNote(
    String note,
    DateTime releaseDate,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notepad')
        .add(
      {
        'note': note,
        'date': DateTime.now(),
      },
    );
  }

  Future<TaskModel> getDetalisTask({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .doc(id)
        .get();
    return TaskModel(
      id: doc.id,
      text: doc['text'],
      releaseDate: (doc['date'] as Timestamp).toDate(),
      categoryId: doc['category_id'],
    );
  }

  Future<NoteModel> getDetalisNote({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notepad')
        .doc(id)
        .get();
    return NoteModel(
      id: doc.id,
      note: doc['note'],
      releaseDate: (doc['date'] as Timestamp).toDate(),
    );
  }

  Future<PhotoNoteModel> getDetalisPhotoNote({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photo_note')
        .doc(id)
        .get();
    return PhotoNoteModel(
      id: doc.id,
      photo: doc['photo'],
    );
  }
}
