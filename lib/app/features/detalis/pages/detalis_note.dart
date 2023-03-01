import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class DetalisNotePage extends StatelessWidget {
  const DetalisNotePage({super.key});

  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Color.fromARGB(255, 56, 55, 55),
            ),
          ),
        ],
        gradient: const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
        title: Center(
          child: Text(
            'NOTE',
            style: GoogleFonts.arimo(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 56, 55, 55),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: [Text('notatka')]),
      ),
    );
  }
}
