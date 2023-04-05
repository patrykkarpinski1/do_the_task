import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/cubit/auth_cubit.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class AddUserNamePage extends StatefulWidget {
  const AddUserNamePage({super.key});

  @override
  State<AddUserNamePage> createState() => _AddUserNamePageState();
}

class _AddUserNamePageState extends State<AddUserNamePage> {
  String? name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 225, 234),
      appBar: NewGradientAppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 56, 55, 55),
            )),
        gradient: const LinearGradient(
          colors: [Colors.cyan, Colors.indigo],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Add Your Name',
              textAlign: TextAlign.center,
              style: GoogleFonts.arimo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 32, 31, 31),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              onChanged: (newValue) {
                setState(() {
                  name = newValue;
                });
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 160,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.cyan, Colors.indigo],
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
              onPressed: () {
                context.read<AuthCubit>().addUserName(name: name!);
                Navigator.of(context).pop();
              },
              child: Text(
                'Save',
                style: GoogleFonts.arimo(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 32, 31, 31),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
