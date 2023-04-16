import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/repositories/login_repository.dart';
part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.loginRepository}) : super(const AuthState());
  final LoginRepository loginRepository;

  Future<void> passwordReset({
    required String email,
  }) async {
    try {
      await loginRepository.passwordReset(email: email);
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
      await loginRepository.signOut();
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
        await loginRepository.register(email: email, password: password);
        try {
          await loginRepository.sendEmailVerification();
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
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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
    try {
      await loginRepository.addUserName(name: name);
    } catch (error) {
      emit(AuthState(status: Status.error, errorMessage: error.toString()));
    }
  }

  Future<void> addUserPhoto({
    required XFile image,
  }) async {
    try {
      await loginRepository.addUserPhoto(image: image);
    } catch (error) {
      emit(AuthState(status: Status.error, errorMessage: error.toString()));
    }
  }

  // Future<void> deleteUserDocuments() async {
  //   try {
  //     await loginRepository.deleteUserDocuments();
  //   } catch (error) {
  //     emit(AuthState(status: Status.error, errorMessage: error.toString()));
  //   }
  // }

  Future<void> deleteAccount() async {
    try {
      await loginRepository.deleteAccount();
      start();
    } on FirebaseAuthException catch (error) {
      emit(AuthState(
          status: Status.error, errorMessage: error.message.toString()));
    }
  }

  Future<void> userReloded() async {
    await FirebaseAuth.instance.currentUser?.reload();
    emit(AuthState(
        user: FirebaseAuth.instance.currentUser, status: state.status));
  }

  Future<void> resendEmailVerification() async {
    try {
      await loginRepository.sendEmailVerification();
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

      _streamSubscription = FirebaseAuth.instance.userChanges().listen((user) {
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
