import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

@injectable
class ItemsRemoteDataSources {
  Future<List<Map<String, dynamic>>> getCategories() async {
    final doc = await FirebaseFirestore.instance.collection('categories').get();
    final listDynamic = doc.docs;
    return listDynamic.map((doc) {
      final json = doc.data();
      json['id'] = doc.id;
      return json;
    }).toList();
  }

  Future<Map<String, dynamic>> getCategory({required String id}) async {
    final doc =
        await FirebaseFirestore.instance.collection('categories').doc(id).get();
    final json = doc.data();
    json!['id'] = doc.id;
    return json;
  }

  Future<void> addPhotos(
    XFile image,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final ref = firebase_storage.FirebaseStorage.instance
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

  Stream<List<Map<String, dynamic>>> getPhotosStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photo_note')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final json = doc.data();
        json['id'] = doc.id;
        return json;
      }).toList();
    });
  }

  Future<List<Map<String, dynamic>>> getTasks({
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
    final listDynamic = doc.docs;
    return listDynamic.map((doc) {
      final json = doc.data();
      json['id'] = doc.id;
      return json;
    }).toList();
  }

  Stream<List<Map<String, dynamic>>> getNotesStream() {
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
        final json = doc.data();
        json['id'] = doc.id;
        return json;
      }).toList();
    });
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

  Future<void> deletePhotoStorage({
    required String photo,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    firebase_storage.Reference photoRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .storage
        .refFromURL(photo);
    await photoRef.delete();
  }

  Future<void> deletePhotoDocument({
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

  Future<Map<String, dynamic>> getDetalisTask({required String id}) async {
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
    final json = doc.data();
    json!['id'] = doc.id;
    return json;
  }

  Future<Map<String, dynamic>> getDetalisNote({required String id}) async {
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
    final json = doc.data();
    json!['id'] = doc.id;
    return json;
  }

  Future<Map<String, dynamic>> getDetalisPhotoNote({required String id}) async {
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
    final json = doc.data();
    json!['id'] = doc.id;
    return json;
  }

  Future<void> editNote({
    required String id,
    required String note,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notepad')
        .doc(id)
        .update(
      {
        'note': note,
      },
    );
  }
}
