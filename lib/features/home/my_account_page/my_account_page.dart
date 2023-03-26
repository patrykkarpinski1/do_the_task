import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/cubit/auth_cubit.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({
    required this.email,
    Key? key,
  }) : super(key: key);
  final String? email;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: NewGradientAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 56, 55, 55),
              ),
            ),
            gradient:
                const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
            title: Text(
              'Your Profile',
              style: GoogleFonts.arimo(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 56, 55, 55),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                    context.read<AuthCubit>().start();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 56, 55, 55),
                  ))
            ],
          ),
          body: ListView(
            children: [
              Text('jesteś zalogowany jako $email'),
            ],
          ),
        );
      },
    );
  }
}
