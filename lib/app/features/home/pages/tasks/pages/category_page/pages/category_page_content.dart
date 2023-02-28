import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/auth/pages/user_profile.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_page/cubit/category_page_cubit.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/tasks_pages/pages/task_page/tasks_page.dart';
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
        child: Scaffold(
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
          body: BlocBuilder<CategoryPageCubit, CategoryPageState>(
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
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  children: [
                    for (final categoryModel in categoryModels) ...[
                      CategoryWidget(categoryModel: categoryModel),
                    ]
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    required this.categoryModel,
    Key? key,
  }) : super(key: key);
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => TasksPage(id: categoryModel.id)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
                  image: AssetImage(categoryModel.images!),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  categoryModel.title,
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
