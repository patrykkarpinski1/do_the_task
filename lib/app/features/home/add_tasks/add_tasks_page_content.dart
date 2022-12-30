import 'package:flutter/material.dart';
import 'package:modyfikacja_aplikacja/app/features/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTasksPageContent extends StatelessWidget {
  const AddTasksPageContent({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final HomePage widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 171, 175),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
              color: Color.fromARGB(255, 247, 143, 15),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 1, 100, 146),
        title: Text(
          'ADD NEW TASKS',
          style: GoogleFonts.rubikBeastly(
            color: const Color.fromARGB(255, 247, 143, 15),
          ),
        ),
      ),
    );
  }
}
