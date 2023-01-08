import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/check/pages/category_pages/learning_page/cubit/learning_cubit.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({
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
          'LEARNING',
          style: GoogleFonts.rubikBeastly(
            color: const Color.fromARGB(255, 247, 143, 15),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => LearningCubit()..start(),
        child: BlocBuilder<LearningCubit, LearningState>(
          builder: (context, state) {
            final docs = state.tasks?.docs;
            if (docs == null) {
              return const SizedBox.shrink();
            }
            return ListView(
              children: [
                for (final doc in docs) ...[
                  LearningTasks(
                    document: doc,
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class LearningTasks extends StatelessWidget {
  const LearningTasks({
    required this.document,
    Key? key,
  }) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> document;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 133, 220, 223),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 180,
                    height: 180,
                    color: const Color.fromARGB(255, 49, 171, 175),
                    child: Text(
                      document['text'],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 120,
                    color: const Color.fromARGB(255, 49, 171, 175),
                    child: Text(
                      (document['date'] as Timestamp).toDate().toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  IconButton(
                    onPressed: () {
                      context
                          .read<LearningCubit>()
                          .remove(documentID: document.id);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
