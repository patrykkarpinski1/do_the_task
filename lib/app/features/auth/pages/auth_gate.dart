import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:modyfikacja_aplikacja/app/features/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return const SignInScreen(
            providerConfigs: [
              EmailProviderConfiguration(),
            ],
          );
        }

        // Render your application if authenticated
        return const HomePage();
      },
    );
  }
}
