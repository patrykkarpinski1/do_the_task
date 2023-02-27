import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/auth/pages/user_profile.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_page/cubit/category_page_cubit.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/tasks_pages/pages/fees_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/tasks_pages/pages/family_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/tasks_pages/pages/entertainment_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/tasks_pages/pages/house_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/tasks_pages/pages/learning_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/tasks_pages/pages/other_tasks_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/tasks_pages/pages/shopping_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/tasks_pages/pages/sport_workouts_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/tasks_pages/pages/work_page.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class CategoryPageContent extends StatefulWidget {
  const CategoryPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryPageContent> createState() => _CategoryPageContentState();
}

class _CategoryPageContentState extends State<CategoryPageContent> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryPageCubit(ItemsRepository())..start(),
      child: BlocListener<CategoryPageCubit, CategoryPageState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        child: BlocBuilder<CategoryPageCubit, CategoryPageState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Scaffold(
                backgroundColor: Colors.cyan,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            final categoryModels = state.categories;
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 208, 225, 234),
              appBar: NewGradientAppBar(
                gradient:
                    const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
                title: Center(
                  child: Text(
                    'CHOOSE TASKS CATEGORY',
                    style: GoogleFonts.arimo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 56, 55, 55),
                    ),
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
                      color: Color.fromARGB(255, 56, 55, 55),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  children: [
                    TaskWidget(
                      color: isPressed
                          ? Colors.white
                          : const Color.fromARGB(255, 233, 210, 12),
                      image: const AssetImage('images/working.png'),
                      categoryModels[5],
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const WorkPage(),
                          ),
                        );
                      },
                    ),
                    TaskWidget(
                      color: isPressed
                          ? Colors.white
                          : const Color.fromARGB(255, 233, 210, 12),
                      image: const AssetImage('images/house.png'),
                      categoryModels[8],
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const HousePage(),
                          ),
                        );
                      },
                    ),
                    TaskWidget(
                      color: isPressed
                          ? Colors.white
                          : const Color.fromARGB(255, 233, 210, 12),
                      image: const AssetImage('images/sport.png'),
                      categoryModels[6],
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const TrainingPage(),
                          ),
                        );
                      },
                    ),
                    TaskWidget(
                      color: isPressed
                          ? Colors.white
                          : const Color.fromARGB(255, 233, 210, 12),
                      image: const AssetImage('images/money.png'),
                      categoryModels[1],
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BillsPage(),
                          ),
                        );
                      },
                    ),
                    TaskWidget(
                      color: isPressed
                          ? Colors.white
                          : const Color.fromARGB(255, 233, 210, 12),
                      image: const AssetImage('images/family.png'),
                      categoryModels[4],
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const FamilyPage(),
                          ),
                        );
                      },
                    ),
                    TaskWidget(
                      color: isPressed
                          ? Colors.white
                          : const Color.fromARGB(255, 233, 210, 12),
                      image: const AssetImage('images/game.png'),
                      categoryModels[3],
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const FunPage(),
                          ),
                        );
                      },
                    ),
                    TaskWidget(
                      color: isPressed
                          ? Colors.white
                          : const Color.fromARGB(255, 233, 210, 12),
                      image: const AssetImage('images/shopping.png'),
                      categoryModels[0],
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ShoppingPage(),
                          ),
                        );
                      },
                    ),
                    TaskWidget(
                      color: isPressed
                          ? Colors.white
                          : const Color.fromARGB(255, 233, 210, 12),
                      image: const AssetImage('images/learning.png'),
                      categoryModels[2],
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const LearnPage(),
                          ),
                        );
                      },
                    ),
                    TaskWidget(
                      color: isPressed
                          ? Colors.white
                          : const Color.fromARGB(255, 233, 210, 12),
                      image: const AssetImage('images/task.png'),
                      categoryModels[7],
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const OtherPage(),
                          ),
                        );
                      },
                    ),
                    TaskWidget(
                      color: isPressed
                          ? Colors.white
                          : const Color.fromARGB(255, 233, 210, 12),
                      image: const AssetImage('images/travel.png'),
                      categoryModels[9],
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
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

class TaskWidget extends StatefulWidget {
  const TaskWidget(
    this.categoryModel, {
    Key? key,
    this.onTap,
    required this.image,
    required this.color,
  }) : super(key: key);
  final CategoryModel categoryModel;
  final void Function()? onTap;
  final ImageProvider<Object> image;
  // Color color;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
  final Color color;
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 5,
            right: 5,
            top: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(
                  image: widget.image,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  widget.categoryModel.title,
                  style: GoogleFonts.arimo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
