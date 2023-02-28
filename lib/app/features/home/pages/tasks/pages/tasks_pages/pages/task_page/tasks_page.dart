import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_page/cubit/category_page_cubit.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';
import 'package:modyfikacja_aplikacja/widgets/tasks_widget.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({
    required this.id,
    this.categoryModel,
    this.taskmodel,
    Key? key,
  }) : super(key: key);
  final CategoryModel? categoryModel;
  final String id;
  final TaskModel? taskmodel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryPageCubit(ItemsRepository())..getCategoryWithID(id),
      child: BlocBuilder<CategoryPageCubit, CategoryPageState>(
        builder: (context, state) {
          final categoryModel = state.categoryModel;
          if (categoryModel == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
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
                categoryModel.title,
                style: GoogleFonts.rubikBeastly(
                  color: const Color.fromARGB(255, 247, 143, 15),
                ),
              ),
            ),
            body: TasksWidget(
              categoryId: categoryModel.id,
            ),
          );
        },
      ),
    );
  }
}
