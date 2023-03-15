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
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  action == AuthAction.signIn
                      ? 'Welcome to FlutterFire UI! Please sign in to continue.'
                      : 'Welcome to FlutterFire UI! Please create an account to continue',
                ),
              );
            },
            footerBuilder: (context, _) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            headerBuilder: (context, constraints, _) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: AspectRatio(
                    aspectRatio: 1,
                    child: Image(image: AssetImage('images/checklist.webp'))),
              );
            },
            providerConfigs: const [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                clientId: '',
              ),
            ],
          );
        }

        // Render your application if authenticated
        return const HomePage();
      },
    );
  }
}
