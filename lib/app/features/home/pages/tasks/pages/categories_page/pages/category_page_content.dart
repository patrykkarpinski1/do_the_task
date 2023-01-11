import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/auth/pages/user_profile.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/categories_page/cubit/tasks_page_cubit.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_pages/fees_page/pages/fees_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_pages/family_page/pages/family_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_pages/entertainment_page/pages/entertainment_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_pages/house_page/pages/house_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_pages/learning_page/pages/learning_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_pages/other_tasks_page/pages/other_tasks_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_pages/shopping_page/pages/shopping_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_pages/sport_workouts_page/pages/sport_workouts_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_pages/work_page/pages/work_page/work_page.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';

class TaskPageContent extends StatelessWidget {
  const TaskPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskPageCubit()..start(),
      child: BlocListener<TaskPageCubit, TaskPageState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        child: BlocBuilder<TaskPageCubit, TaskPageState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Scaffold(
                backgroundColor: Color.fromARGB(255, 49, 171, 175),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            final categoryModels = state.categories;
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
                      categoryModels[5],
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const WorkPage(),
                          ),
                        );
                      },
                    ),
                    CategoryWidget(
                      categoryModels[8],
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const HousePage(),
                          ),
                        );
                      },
                    ),
                    CategoryWidget(
                      categoryModels[6],
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const TrainingPage(),
                          ),
                        );
                      },
                    ),
                    CategoryWidget(
                      categoryModels[1],
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BillsPage(),
                          ),
                        );
                      },
                    ),
                    CategoryWidget(
                      categoryModels[4],
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const FamilyPage(),
                          ),
                        );
                      },
                    ),
                    CategoryWidget(
                      categoryModels[3],
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const FunPage(),
                          ),
                        );
                      },
                    ),
                    CategoryWidget(
                      categoryModels[0],
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ShoppingPage(),
                          ),
                        );
                      },
                    ),
                    CategoryWidget(
                      categoryModels[2],
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const LearnPage(),
                          ),
                        );
                      },
                    ),
                    CategoryWidget(
                      categoryModels[7],
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
          },
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
    this.categoryModel, {
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final CategoryModel categoryModel;
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
          categoryModel.title,
          style: GoogleFonts.arimo(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 247, 143, 15),
          ),
        ),
      ),
    );
  }
}
