import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'dart:io';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  Future<void> passwordReset({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      emit(const AuthState(
          status: Status.success,
          message: 'Password reset link sent! Please check your email '));
    } on FirebaseAuthException catch (error) {
      emit(AuthState(
          status: Status.error, errorMessage: error.message.toString()));
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .whenComplete(() {
      users.doc(FirebaseAuth.instance.currentUser!.uid).set({
        'name': googleUser!.displayName,
        'profile_image': googleUser.photoUrl,
      });
    });
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(
        const AuthState(status: Status.success),
      );
    } on FirebaseAuthException catch (error) {
      emit(AuthState(
          status: Status.error, errorMessage: error.message.toString()));
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
    String? name,
    XFile? image,
  }) async {
    if (password.trim() != confirmPassword.trim()) {
      emit(
        const AuthState(
          status: Status.error,
          errorMessage: 'Passwords don\'t match',
          isCreatingAccount: true,
        ),
      );
    } else {
      try {
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        users.doc(FirebaseAuth.instance.currentUser!.uid).set({
          'name': name,
          'profile_image': image,
        });
        emit(const AuthState(isCreatingAccount: false));
        try {
          await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        } on FirebaseAuthException catch (error) {
          emit(AuthState(
              status: Status.error, errorMessage: error.message.toString()));
        }
      } on FirebaseAuthException catch (error) {
        emit(AuthState(
          status: Status.error,
          errorMessage: error.message.toString(),
          isCreatingAccount: true,
        ));
      }
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user?.emailVerified == false) {
        emit(const AuthState(
          status: Status.success,
          message: 'please check your inbox and verify your email',
        ));
      }
    } on FirebaseAuthException catch (error) {
      emit(AuthState(
          status: Status.error, errorMessage: error.message.toString()));
    }
  }

  Future<void> creatingAccount() async {
    emit(
      const AuthState(
        user: null,
        isCreatingAccount: true,
      ),
    );
  }

  Future<void> notCreatingAccount() async {
    emit(
      const AuthState(
        user: null,
        isCreatingAccount: false,
      ),
    );
  }

  Future<void> addUserName({required String name}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    try {
      await FirebaseFirestore.instance.collection('users').doc(userID).update({
        'name': name,
      });
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
    } catch (error) {
      emit(AuthState(status: Status.error, errorMessage: error.toString()));
    }
  }

  Future<void> addUserPhoto({
    required XFile image,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    try {
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
    } catch (error) {
      emit(AuthState(status: Status.error, errorMessage: error.toString()));
    }
  }

  Future<void> deleteAccount() async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    try {
      await FirebaseAuth.instance.currentUser?.delete();
    } on FirebaseAuthException catch (error) {
      emit(AuthState(
          status: Status.error, errorMessage: error.message.toString()));
    }
  }

  Future<void> resendEmailVerification() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (error) {
      emit(AuthState(
          status: Status.error, errorMessage: error.message.toString()));
    }
  }

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    try {
      emit(
        const AuthState(
          user: null,
          status: Status.loading,
          errorMessage: '',
          isCreatingAccount: false,
        ),
      );

      _streamSubscription =
          FirebaseAuth.instance.authStateChanges().listen((user) {
        emit(
          AuthState(
            status: Status.success,
            user: user,
          ),
        );
      });
    } on FirebaseAuthException catch (error) {
      emit(AuthState(
          status: Status.error, errorMessage: error.message.toString()));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
