import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNotes extends StatelessWidget {
  const AddNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 171, 175),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check,
              color: Color.fromARGB(255, 247, 143, 15),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 1, 100, 146),
        title: Text(
          'NOTE',
          style: GoogleFonts.rubikBeastly(
            color: const Color.fromARGB(255, 247, 143, 15),
          ),
        ),
      ),
      body: ListView(
        children: const [
          TextField(),
        ],
      ),
    );
  }
}
