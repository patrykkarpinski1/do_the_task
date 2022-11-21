import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMassge = '';
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
                  height: 10,
                ),
                Text(
                  'LOGOWANIE',
                  style: GoogleFonts.kanit(fontSize: 16),
                ),
                TextField(
                  controller: widget.emailController,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                ),
                TextField(
                  controller: widget.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Hasło'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(errorMassge),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } catch (error) {
                      setState(() {
                        errorMassge = error.toString();
                      });
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
