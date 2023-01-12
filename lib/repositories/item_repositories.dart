import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/models/note_model.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';

class ItemsRepository {
  Stream<List<CategoryModel>> getCategoriesStream() {
    return FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return (CategoryModel(
          id: doc.id,
          title: doc['title'],
        ));
      }).toList();
    });
  }

  Stream<List<NoteModel>> getNotesStream() {
    return FirebaseFirestore.instance
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
    return FirebaseFirestore.instance.collection('notepad').doc(id).delete();
  }

  Future<void> addNote(String note) async {
    await FirebaseFirestore.instance.collection('notepad').add(
      {'note': note},
    );
  }

  Stream<List<TaskModel>> getWorkStream() {
    return FirebaseFirestore.instance
        .collection('tasks')
        .where("category_id", isEqualTo: "kmwtczQ4I989UJaG9ukI")
        .snapshots()
        .map((querySnapschot) {
      return querySnapschot.docs.map((doc) {
        return (TaskModel(
          id: doc.id,
          text: doc['text'],
          releaseDate: (doc['date'] as Timestamp).toDate(),
        ));
      }).toList();
    });
  }

  Future<void> deleteWork({required String id}) async {
    await FirebaseFirestore.instance.collection('tasks').doc(id).delete();
  }

  Future<void> addWork(
    String text,
    DateTime releaseDate,
    TimeOfDay releaseTime,
  ) async {
    await FirebaseFirestore.instance.collection('tasks').add({
      'text': text,
      'category_id': 'kmwtczQ4I989UJaG9ukI',
      'date': releaseDate,
    });
  }

  Future<TaskModel> getWork({required String id}) async {
    final doc =
        await FirebaseFirestore.instance.collection('tasks').doc(id).get();
    return TaskModel(
      id: doc.id,
      text: doc['text'],
      releaseDate: (doc['date'] as Timestamp).toDate(),
    );
  }
}
