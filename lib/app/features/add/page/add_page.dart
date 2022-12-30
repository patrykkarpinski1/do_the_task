import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 171, 175),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 100, 146),
        title: Text(
          'CREATE A NEW TASKS',
          style: GoogleFonts.rubikBeastly(
            color: const Color.fromARGB(255, 247, 143, 15),
          ),
        ),
      ),
    );
  }
}
