import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/auth/pages/user_profile.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/check/category_pages/bills_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/check/category_pages/family_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/check/category_pages/fun_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/check/category_pages/house_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/check/category_pages/learn_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/check/category_pages/other_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/check/category_pages/shopping_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/check/category_pages/trainig_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/check/category_pages/work_page.dart';

class CheckPageContent extends StatelessWidget {
  const CheckPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('wystąpił błąd'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('ładowanie strony'));
          }
          final documents = snapshot.data!.docs;
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 49, 171, 175),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 1, 100, 146),
              title: Text(
                'CHOOSE TASKS CATEGORY',
                style: GoogleFonts.rubikBeastly(
                  color: const Color.fromARGB(255, 247, 143, 15),
                ),
              ),
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
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  CategoryWidget(
                    documents[5]['title'],
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const WorkPage(),
                        ),
                      );
                    },
                  ),
                  CategoryWidget(
                    documents[8]['title'],
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const HousePage(),
                        ),
                      );
                    },
                  ),
                  CategoryWidget(
                    documents[6]['title'],
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const TrainingPage(),
                        ),
                      );
                    },
                  ),
                  CategoryWidget(
                    documents[1]['title'],
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const BillsPage(),
                        ),
                      );
                    },
                  ),
                  CategoryWidget(
                    documents[4]['title'],
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const FamilyPage(),
                        ),
                      );
                    },
                  ),
                  CategoryWidget(
                    documents[3]['title'],
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const FunPage(),
                        ),
                      );
                    },
                  ),
                  CategoryWidget(
                    documents[0]['title'],
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ShoppingPage(),
                        ),
                      );
                    },
                  ),
                  CategoryWidget(
                    documents[2]['title'],
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const LearnPage(),
                        ),
                      );
                    },
                  ),
                  CategoryWidget(
                    documents[7]['title'],
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const OtherPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
    this.title, {
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          backgroundColor: const Color.fromARGB(255, 1, 100, 146),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: GoogleFonts.arimo(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 247, 143, 15),
          ),
        ),
      ),
    );
  }
}
