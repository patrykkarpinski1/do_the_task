import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/core/enums.dart';
import '/app/cubit/auth_cubit.dart';
import '/widgets/login_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == Status.error) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.errorMessage),
              ),
            );
          }
        }
        if (state.status == Status.success) {
          if (state.message.isNotEmpty) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      content: Text(
                    state.message,
                    style: GoogleFonts.arimo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 32, 31, 31),
                    ),
                  ));
                });
          }
        }
        if (state.user?.emailVerified == false) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    content: Text(
                  'please check your inbox and verify your email',
                  style: GoogleFonts.arimo(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 32, 31, 31),
                  ),
                ));
              });
        }
      },
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromARGB(255, 168, 53, 189),
                  Color.fromARGB(255, 202, 151, 73)
                ])),
            child: ListView(
              padding: const EdgeInsets.all(25),
              children: [
                const SizedBox(
                  height: 250,
                  child: Image(
                    image: AssetImage('images/computer.png'),
                  ),
                ),
                LoginWidget(
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 50, 50, 20),
                  child: Material(
                    color: const Color.fromARGB(255, 168, 53, 189),
                    elevation: 3,
                    borderRadius: BorderRadius.circular(30),
                    child: MaterialButton(
                      onPressed: () {
                        context.read<AuthCubit>().signInWithGoogle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(FontAwesomeIcons.google),
                          Text(
                            'Sign In With Google',
                            style: GoogleFonts.arimo(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
