@Timeout(Duration(seconds: 5))
import 'package:bloc_test/bloc_test.dart';
import 'package:do_the_task/app/core/enums.dart';
import 'package:do_the_task/app/cubit/auth_cubit.dart';
import 'package:do_the_task/repositories/login_repository.dart';
import 'package:do_the_task/services/notifi_serivice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late AuthCubit sut;
  late MockLoginRepository loginRepository;
  late NotificationService notificationService;

  setUp(() {
    notificationService = MockNotificationService();
    loginRepository = MockLoginRepository();
    sut = AuthCubit(
        loginRepository: loginRepository,
        notificationService: notificationService);
  });
  group('passwordReset', () {
    const email = 'test@example.com';
    group('success', () {
      setUp(() {
        when(() => loginRepository.passwordReset(email: email))
            .thenAnswer((_) => Future.value());
      });
      blocTest<AuthCubit, AuthState>(
        'emits success status when password reset is successful',
        build: () => sut,
        act: (cubit) => cubit.passwordReset(email: email),
        expect: () => [
          const AuthState(
              status: Status.success,
              message: 'Password reset link sent! Please check your email '),
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => loginRepository.passwordReset(email: email))
            .thenThrow(FirebaseAuthException(
          code: 'error_code',
          message: 'error-message',
        ));
      });
      blocTest<AuthCubit, AuthState>(
        'emits error status when password reset throws FirebaseAuthException',
        build: () => sut,
        act: (cubit) => cubit.passwordReset(email: email),
        expect: () => [
          const AuthState(
            status: Status.error,
            errorMessage: 'error-message',
          ),
        ],
      );
    });
  });
  group('signOut', () {
    group('success', () {
      setUp(() {
        when(() => loginRepository.signOut()).thenAnswer((_) => Future.value());
      });
      blocTest<AuthCubit, AuthState>(
        'emits success status when password reset is successful',
        build: () => sut,
        act: (cubit) {
          cubit.signOut();
          cubit.setIsAppOpenedViaNotification(true);
        },
        expect: () => [
          const AuthState(isAppOpenedViaNotification: true),
          const AuthState(
              status: Status.initial, isAppOpenedViaNotification: false),
          const AuthState(
              status: Status.success, isAppOpenedViaNotification: false),
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => loginRepository.signOut()).thenThrow(FirebaseAuthException(
          code: 'error_code',
          message: 'error-message',
        ));
      });
      blocTest<AuthCubit, AuthState>(
        'emits error status when password reset throws FirebaseAuthException',
        build: () => sut,
        act: (cubit) => cubit.signOut(),
        expect: () => [
          const AuthState(
            status: Status.error,
            errorMessage: 'error-message',
          ),
        ],
      );
    });
  });
  group('register', () {
    const email = 'test@example.com';
    const password = 'password';
    const confirmPassword = 'password';
    const confirmPassword2 = 'diffrentpassword';
    group('passwords do not match', () {
      blocTest<AuthCubit, AuthState>(
        'emits AuthState with Status.error and error message when passwords do not match',
        build: () => sut,
        act: (cubit) => cubit.register(
            email: email,
            password: password,
            confirmPassword: confirmPassword2),
        expect: () => [
          const AuthState(
            status: Status.error,
            errorMessage: 'Passwords don\'t match',
            isCreatingAccount: true,
          ),
        ],
      );
    });
    group('success', () {
      setUp(() {
        when(() => loginRepository.register(email: email, password: password))
            .thenAnswer((_) async {});
        when(() => loginRepository.sendEmailVerification())
            .thenAnswer((_) async {});
      });
      blocTest<AuthCubit, AuthState>(
        'emits AuthState with Status.success when registration succeeds',
        build: () => sut,
        act: (cubit) => cubit.register(
            email: email, password: password, confirmPassword: confirmPassword),
        expect: () => [],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => loginRepository.register(email: email, password: password))
            .thenThrow(FirebaseAuthException(
                code: 'error_code', message: 'error-message'));
      });
      blocTest<AuthCubit, AuthState>(
        'emits AuthState with Status.error and error message when registration fails',
        build: () => sut,
        act: (cubit) => cubit.register(
            email: email, password: password, confirmPassword: confirmPassword),
        expect: () => [
          const AuthState(
            status: Status.error,
            errorMessage: 'error-message',
            isCreatingAccount: true,
          ),
        ],
      );
    });
  });
  group('signIn', () {
    const email = 'test@example.com';
    const password = 'password';

    group('success', () {
      setUp(() {
        when(() => loginRepository.signIn(email: email, password: password))
            .thenAnswer((_) async {});
      });
      blocTest<AuthCubit, AuthState>(
        'emits AuthState with Status.success when signIn succeeds',
        build: () => sut,
        act: (cubit) => cubit.signIn(
          email: email,
          password: password,
        ),
        expect: () => [],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => loginRepository.signIn(email: email, password: password))
            .thenThrow(FirebaseAuthException(
                code: 'error_code', message: 'error-message'));
      });
      blocTest<AuthCubit, AuthState>(
        'emits AuthState with Status.error and error message when signIn fails',
        build: () => sut,
        act: (cubit) => cubit.signIn(
          email: email,
          password: password,
        ),
        expect: () => [
          const AuthState(
            status: Status.error,
            errorMessage: 'error-message',
          ),
        ],
      );
    });
  });
  group('addUserName', () {
    const name = 'name';
    group('success', () {
      setUp(() {
        when(() => loginRepository.addUserName(name: name))
            .thenAnswer((_) async {});
      });
      blocTest<AuthCubit, AuthState>(
        'emits AuthState with Status.success when add user name succeeds',
        build: () => sut,
        act: (cubit) => cubit.addUserName(name: name),
        expect: () => [],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => loginRepository.addUserName(name: name)).thenThrow(
          Exception('test-exception-error'),
        );
      });
      blocTest<AuthCubit, AuthState>(
        'emits AuthState with Status.error and error message when add user name fails',
        build: () => sut,
        act: (cubit) => cubit.addUserName(name: name),
        expect: () => [
          const AuthState(
            status: Status.error,
            errorMessage: 'Exception: test-exception-error',
          ),
        ],
      );
    });
  });
  group('addUserPhoto', () {
    final image = XFile('image');
    group('success', () {
      setUp(() {
        when(() => loginRepository.addUserPhoto(image: image))
            .thenAnswer((_) async {});
      });
      blocTest<AuthCubit, AuthState>(
        'emits AuthState with Status.success when add user image succeeds',
        build: () => sut,
        act: (cubit) => cubit.addUserPhoto(image: image),
        expect: () => [],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => loginRepository.addUserPhoto(image: image)).thenThrow(
          Exception('test-exception-error'),
        );
      });
      blocTest<AuthCubit, AuthState>(
        'emits AuthState with Status.error and error message when add user image fails',
        build: () => sut,
        act: (cubit) => cubit.addUserPhoto(image: image),
        expect: () => [
          const AuthState(
            status: Status.error,
            errorMessage: 'Exception: test-exception-error',
          ),
        ],
      );
    });
  });
  group('deleteAllFiles', () {
    group('success', () {
      setUp(() {
        when(() => loginRepository.deleteAllFiles()).thenAnswer((_) async {});
      });
      blocTest<AuthCubit, AuthState>(
        'emits AuthState with Status.success when deletion all files success',
        build: () => sut,
        act: (cubit) => cubit.deleteAllFiles(),
        expect: () => [],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => loginRepository.deleteAllFiles()).thenThrow(
          Exception('test-exception-error'),
        );
      });
      blocTest<AuthCubit, AuthState>(
        'emits AuthState with Status.error and error messagewhen deletion all files fails',
        build: () => sut,
        act: (cubit) => cubit.deleteAllFiles(),
        expect: () => [
          const AuthState(
            status: Status.error,
            errorMessage: 'Exception: test-exception-error',
          ),
        ],
      );
    });
  });
  group('deleteAccount', () {
    group('success', () {
      setUp(() {
        when(() => loginRepository.deleteAccount()).thenAnswer((_) async {});
      });

      blocTest<AuthCubit, AuthState>(
        'emits AuthState with status Status.loading and then Status.authenticated when account is deleted successfully',
        build: () => sut,
        act: (cubit) => cubit.deleteAccount(),
        expect: () => [],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => loginRepository.deleteAccount()).thenThrow(
          FirebaseAuthException(code: 'error_code', message: 'error_message'),
        );
      });

      blocTest<AuthCubit, AuthState>(
        'emits AuthState with status Status.error and error message when account deletion fails',
        build: () => sut,
        act: (cubit) => cubit.deleteAccount(),
        expect: () => [
          const AuthState(
            status: Status.error,
            errorMessage: 'error_message',
          ),
        ],
      );
    });
  });

  group('resendEmailVerification', () {
    group('success', () {
      setUp(() {
        when(() => loginRepository.sendEmailVerification())
            .thenAnswer((_) async {});
      });

      blocTest<AuthCubit, AuthState>(
        'emits AuthState with status Status.authenticated when resend email verification successfully',
        build: () => sut,
        act: (cubit) => cubit.resendEmailVerification(),
        expect: () => [],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => loginRepository.sendEmailVerification()).thenThrow(
          FirebaseAuthException(code: 'error_code', message: 'error_message'),
        );
      });

      blocTest<AuthCubit, AuthState>(
        'emits AuthState with status Status.error and error message when resend email verification fails',
        build: () => sut,
        act: (cubit) => cubit.resendEmailVerification(),
        expect: () => [
          const AuthState(
            status: Status.error,
            errorMessage: 'error_message',
          ),
        ],
      );
    });
  });
  group('enableNotifications', () {
    group('success', () {
      setUp(() {
        when(() => notificationService.enableFirebaseNotifications())
            .thenAnswer((_) async {});
      });

      blocTest<AuthCubit, AuthState>(
        'emits AuthState with status Status.authenticated when enable notifications successfully',
        build: () => sut,
        act: (cubit) => cubit.enableNotifications(),
        expect: () => [],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => notificationService.enableFirebaseNotifications()).thenThrow(
          Exception('test-exception-error'),
        );
      });

      blocTest<AuthCubit, AuthState>(
        'emits AuthState with status Status.error and error message when enable notifications fails',
        build: () => sut,
        act: (cubit) => cubit.enableNotifications(),
        expect: () => [
          const AuthState(
            status: Status.error,
            errorMessage: 'Exception: test-exception-error',
          ),
        ],
      );
    });
  });
  group('disableNotifications', () {
    group('success', () {
      setUp(() {
        when(() => notificationService.disableFirebaseNotifications())
            .thenAnswer((_) async {});
      });

      blocTest<AuthCubit, AuthState>(
        'emits AuthState with status Status.authenticated when enable notifications successfully',
        build: () => sut,
        act: (cubit) => cubit.disableNotifications(),
        expect: () => [],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => notificationService.disableFirebaseNotifications())
            .thenThrow(
          Exception('test-exception-error'),
        );
      });

      blocTest<AuthCubit, AuthState>(
        'emits AuthState with status Status.error and error message when enable notifications fails',
        build: () => sut,
        act: (cubit) => cubit.disableNotifications(),
        expect: () => [
          const AuthState(
            status: Status.error,
            errorMessage: 'Exception: test-exception-error',
          ),
        ],
      );
    });
  });
  group('setTaskId', () {
    const testTaskId = '123';

    blocTest<AuthCubit, AuthState>(
      'emits state with updated taskId when setTaskId is called',
      build: () => sut,
      act: (cubit) => cubit.setTaskId(testTaskId),
      expect: () => [
        const AuthState(taskId: testTaskId),
      ],
    );
  });
  group('setIsAppOpenedViaNotification', () {
    blocTest<AuthCubit, AuthState>(
      'emits state with updated isAppOpenedViaNotification when called',
      build: () => sut,
      act: (cubit) => cubit.setIsAppOpenedViaNotification(true),
      expect: () => [
        const AuthState(isAppOpenedViaNotification: true),
      ],
    );
  });
}
