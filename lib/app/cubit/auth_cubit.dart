import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_the_task/services/notifi_serivice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '/app/core/enums.dart';
import '/repositories/login_repository.dart';
part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.loginRepository, required this.notificationService})
      : super(const AuthState());
  final LoginRepository loginRepository;
  final NotificationService notificationService;

  Future<void> passwordReset({
    required String email,
  }) async {
    try {
      await loginRepository.passwordReset(email: email);
      emit(state.copyWith(
          status: Status.success,
          message: 'Password reset link sent! Please check your email '));
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(
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
        'notificationsEnabled': true,
      });
    });
  }

  Future<void> signOut() async {
    try {
      await loginRepository.signOut();
      setIsAppOpenedViaNotification(false);
      emit(
        state.copyWith(
            status: Status.success, isAppOpenedViaNotification: false),
      );
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(
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
        state.copyWith(
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
          emit(state.copyWith(
              status: Status.error, errorMessage: error.message.toString()));
        }
      } on FirebaseAuthException catch (error) {
        emit(state.copyWith(
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
      await loginRepository.signIn(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: error.message.toString()));
    }
  }

  Future<void> creatingAccount() async {
    emit(
      state.copyWith(
        user: null,
        isCreatingAccount: true,
      ),
    );
  }

  Future<void> notCreatingAccount() async {
    emit(
      state.copyWith(
        user: null,
        isCreatingAccount: false,
      ),
    );
  }

  Future<void> addUserName({required String name}) async {
    try {
      await loginRepository.addUserName(name: name);
    } catch (error) {
      emit(
          state.copyWith(status: Status.error, errorMessage: error.toString()));
    }
  }

  Future<void> addUserPhoto({
    required XFile image,
  }) async {
    try {
      await loginRepository.addUserPhoto(image: image);
    } catch (error) {
      emit(
          state.copyWith(status: Status.error, errorMessage: error.toString()));
    }
  }

  Future<void> deleteAllFiles() async {
    try {
      await loginRepository.deleteAllFiles();
    } catch (error) {
      emit(
          state.copyWith(status: Status.error, errorMessage: error.toString()));
    }
  }

  Future<void> deleteAccount() async {
    try {
      await loginRepository.deleteAccount();
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: error.message.toString()));
    }
  }

  Future<void> userReloded() async {
    await FirebaseAuth.instance.currentUser?.reload();
    emit(state.copyWith(
        user: FirebaseAuth.instance.currentUser, status: state.status));
  }

  Future<void> resendEmailVerification() async {
    try {
      await loginRepository.sendEmailVerification();
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: error.message.toString()));
    }
  }

  Future<void> enableNotifications() async {
    try {
      notificationService.enableFirebaseNotifications();
    } catch (error) {
      emit(
          state.copyWith(status: Status.error, errorMessage: error.toString()));
    }
  }

  Future<void> disableNotifications() async {
    try {
      notificationService.disableFirebaseNotifications();
    } catch (error) {
      emit(
          state.copyWith(status: Status.error, errorMessage: error.toString()));
    }
  }

  Future<void> setTaskId(String taskId) async {
    emit(state.copyWith(taskId: taskId));
  }

  Future<void> setIsAppOpenedViaNotification(bool value) async {
    emit(state.copyWith(isAppOpenedViaNotification: value));
  }

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    try {
      emit(
        state.copyWith(
          user: null,
          status: Status.loading,
          errorMessage: '',
          isCreatingAccount: false,
        ),
      );
      final initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        emit(state.copyWith(
          taskId: initialMessage.data['task_id'],
          isAppOpenedViaNotification: true,
        ));
      }

      _streamSubscription = FirebaseAuth.instance.userChanges().listen((user) {
        emit(
          state.copyWith(
            status: Status.success,
            user: user,
          ),
        );
        if (user != null) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .snapshots()
              .listen((snapshot) {
            final notificationsEnabled =
                snapshot.data()?['notificationsEnabled'] ?? false;
            emit(state.copyWith(notificationsEnabled: notificationsEnabled));
          });
        }
      });
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: error.message.toString()));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
