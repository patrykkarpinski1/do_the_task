import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/cubit/auth_cubit.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state.isCreatingAccount == false) ...[
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'E-mail'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'forget password ?',
                        style: GoogleFonts.arimo(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: const Color.fromARGB(255, 32, 31, 31),
                        ),
                      )),
                ],
              ),
            ],
            if (state.isCreatingAccount == true) ...[
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'E-mail'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Confirm Password'),
              ),
            ],
            const SizedBox(height: 20),
            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 147, 33, 168),
                    Color.fromARGB(255, 234, 197, 141)
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () async {
                  if (state.isCreatingAccount == true) {
                    await context.read<AuthCubit>().register(
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                        );
                  } else {
                    await context.read<AuthCubit>().signIn(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  }
                },
                child: Text(
                  state.isCreatingAccount == true ? 'Register' : 'Login',
                  style: GoogleFonts.arimo(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 32, 31, 31),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (state.isCreatingAccount == false) ...[
              TextButton(
                onPressed: () {
                  context.read<AuthCubit>().creatingAccount();
                },
                child: Text(
                  'Create account',
                  style: GoogleFonts.arimo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 56, 55, 55),
                  ),
                ),
              ),
            ],
            if (state.isCreatingAccount == true) ...[
              TextButton(
                onPressed: () {
                  context.read<AuthCubit>().notCreatingAccount();
                },
                child: Text(
                  'Already have an account ?',
                  style: GoogleFonts.arimo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 56, 55, 55),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
