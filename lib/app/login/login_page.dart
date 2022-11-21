import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 49, 171, 175),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 100, 146),
          title: Text(
            'TWÓJ CODZIENNY PLANER',
            style: GoogleFonts.rubikBeastly(),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Image(
                  image: AssetImage('images/checklist.webp'),
                  width: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'LOGOWANIE',
                  style: GoogleFonts.kanit(fontSize: 16),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Hasło'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    } catch (error) {
                      print(error);
                    }
                  },
                  child: const Text('Zaloguj się'),
                )
              ],
            ),
          ),
        ));
  }
}
