import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/auth/pages/user_profile.dart';

class NotebookPageContent extends StatelessWidget {
  const NotebookPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 171, 175),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const UserProfile(),
                ),
              );
            },
            icon: const Icon(
              Icons.person,
              color: Color.fromARGB(255, 247, 143, 15),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 1, 100, 146),
        title: Text(
          'NOTEBOOK',
          style: GoogleFonts.rubikBeastly(
            color: const Color.fromARGB(255, 247, 143, 15),
          ),
        ),
      ),
    );
  }
}
