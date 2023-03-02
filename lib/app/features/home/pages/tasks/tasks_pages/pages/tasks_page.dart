import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/category_page/cubit/category_page_cubit.dart';
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
      child: BlocConsumer<CategoryPageCubit, CategoryPageState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            final errorMessage = state.errorMessage ?? 'Unkown error';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == Status.initial) {
            return const Center(
              child: Text('Initial state'),
            );
          }
          if (state.status == Status.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == Status.success) {
            if (state.categoryModel == null) {
              return const SizedBox.shrink();
            }
          }
          final categoryModel = state.categoryModel;

          return Scaffold(
            backgroundColor: const Color.fromARGB(237, 255, 255, 255),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(142, 15, 193, 107),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              title: Text(
                categoryModel!.title,
                style: GoogleFonts.gruppo(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
