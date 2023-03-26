import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(
      const AuthState(status: Status.success),
    );
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
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        try {
          await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        } catch (error) {
          emit(
            AuthState(
              status: Status.error,
              errorMessage: error.toString(),
            ),
          );
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          emit(
            const AuthState(
              status: Status.error,
              errorMessage: 'The password provided is too weak.',
              isCreatingAccount: false,
            ),
          );
        } else if (error.code == 'email-already-in-use') {
          emit(
            const AuthState(
              status: Status.error,
              errorMessage: 'The account already exists for that email.',
              isCreatingAccount: false,
            ),
          );
        }
      } catch (error) {
        emit(
          AuthState(
            user: null,
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
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
      emit(
        const AuthState(status: Status.success),
      );
    } catch (error) {
      emit(AuthState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
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

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const AuthState(
        user: null,
        status: Status.loading,
        errorMessage: '',
        isCreatingAccount: false,
      ),
    );

    _streamSubscription = FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        emit(
          AuthState(
            status: Status.success,
            user: user,
          ),
        );
      },
    )..onError(
        (error) {
          emit(
            AuthState(
              user: null,
              errorMessage: error.toString(),
            ),
          );
        },
      );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
