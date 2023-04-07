import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'dart:io';

class LoginRepository {
  LoginRepository();
  Future<void> passwordReset({
    required String email,
  }) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> register({
    required String email,
    required String password,
    String? name,
    XFile? image,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    users.doc(FirebaseAuth.instance.currentUser!.uid).set({
      'name': name,
      'profile_image': image,
    });
  }

  Future<void> addUserName({required String name}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }

    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      'name': name,
    });
    await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
  }

  Future<void> addUserPhoto({
    required XFile image,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }

    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profil_images')
        .child(path.basename(image.path));
    await ref.putFile(File(image.path));
    final url = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      'profile_image': url,
    });
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
  }

  Future<void> sendEmailVerification() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  Future<void> deleteAccount() async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }

    await FirebaseAuth.instance.currentUser?.delete();
  }
}
