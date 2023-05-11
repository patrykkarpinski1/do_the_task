import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/core/enums.dart';
import '/app/injection_container.dart';
import '/features/home/pages/category_page/cubit/category_page_cubit.dart';
import '/models/task_model.dart';
import '/widgets/tasks_widget.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({
    required this.id,
    this.taskmodel,
    Key? key,
  }) : super(key: key);
  final String id;
  final TaskModel? taskmodel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryPageCubit>(
      create: (context) => getIt()..getCategoryWithID(id),
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
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.status == Status.success) {
            if (state.selectCategories == null) {
              return const SizedBox.shrink();
            }
          }
          final categoryModel = state.selectCategories;

          return Scaffold(
            appBar: NewGradientAppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              gradient: LinearGradient(colors: [
                Theme.of(context).focusColor,
                Theme.of(context).bottomAppBarColor,
              ]),
              title: Text(
                categoryModel?.title ?? 'Unkown',
                style: GoogleFonts.arimo(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ),
            body: TasksWidget(
              categoryId: categoryModel?.id ?? 'Unkown',
            ),
          );
        },
      ),
    );
  }
}
