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
  var isCreatingAccount = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 49, 171, 175),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 100, 146),
          title: Text(
            'YOURS TASKS LIST',
            style: GoogleFonts.rubikBeastly(
              color: const Color.fromARGB(255, 247, 143, 15),
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                const CircleAvatar(
                    backgroundImage: AssetImage('images/checklist.webp'),
                    radius: 150),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    isCreatingAccount == true ? 'REGISTRATION' : 'LOGIN',
                    style: GoogleFonts.kanit(fontSize: 16),
                  ),
                ),
                TextField(
                  controller: widget.emailController,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                ),
                TextField(
                  controller: widget.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(errorMassge),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: const Color.fromARGB(255, 1, 100, 146),
                  ),
                  onPressed: () async {
                    if (isCreatingAccount == true) {
                      //rejstracja
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: widget.emailController.text,
                          password: widget.passwordController.text,
                        );
                      } catch (error) {
                        setState(() {
                          errorMassge = error.toString();
                        });
                      }
                    } else {
                      //logowanie
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
                    }
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
                  child: Text(
                    isCreatingAccount == true ? 'Register' : 'Login',
                    style: GoogleFonts.arimo(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 247, 143, 15)),
                  ),
                ),
                if (isCreatingAccount == false) ...[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isCreatingAccount = true;
                      });
                    },
                    child: Text(
                      'Create Account',
                      style: GoogleFonts.arimo(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
                if (isCreatingAccount == true) ...[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isCreatingAccount = false;
                      });
                    },
                    child: Text(
                      'Do you have an account?',
                      style: GoogleFonts.arimo(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ));
  }
}
