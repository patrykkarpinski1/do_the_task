import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 171, 175),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 247, 143, 15),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 100, 146),
        title: Text(
          'OTHER TASKS',
          style: GoogleFonts.rubikBeastly(
            color: const Color.fromARGB(255, 247, 143, 15),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            color: const Color.fromARGB(255, 1, 100, 146),
            child: Text(
              'zrób zadanie',
              style: GoogleFonts.arimo(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 247, 143, 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
