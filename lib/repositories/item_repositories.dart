import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/models/note_model.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';

class ItemsRepository {
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

  Future<void> addNote(String note) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notepad')
        .add(
      {'note': note},
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
}
