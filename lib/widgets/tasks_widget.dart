import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/features/detalis/pages/detalis_task_widget_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/cubit/task_cubit.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

class TasksWidget extends StatelessWidget {
  const TasksWidget({
    required this.categoryId,
    Key? key,
  }) : super(key: key);

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(ItemsRepository())..getTasks(categoryId),
      child: BlocConsumer<TaskCubit, TaskState>(
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
            if (state.tasks.isEmpty) {
              return const SizedBox.shrink();
            }
          }
          final taskModels = state.tasks;
          return ListView(
            children: [
              for (final taskModel in taskModels) ...[
                Dismissible(
                  key: ValueKey(taskModel.id),
                  background: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 248, 33, 18),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 32.0),
                        child: Icon(
                          Icons.delete_sweep,
                        ),
                      ),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    // only from left to right
                    return direction == DismissDirection.startToEnd;
                  },
                  onDismissed: (direction) {
                    context.read<TaskCubit>().remove(
                          documentID: taskModel.id,
                        );
                  },
                  child: _TasksWidget(taskmodel: taskModel),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _TasksWidget extends StatelessWidget {
  const _TasksWidget({
    Key? key,
    required this.taskmodel,
  }) : super(key: key);

  final TaskModel? taskmodel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    color: Colors.white,
                    child: Text(
                      taskmodel!.text,
                      style: GoogleFonts.gruppo(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.cyan, Colors.indigo],
                      ),
                      borderRadius: BorderRadius.circular(55),
                    ),
                    width: 150,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                DetalisTasksWidget(id: taskmodel!.id),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(55),
                        ),
                      ),
                      child: Text(
                        'Read',
                        style: GoogleFonts.gruppo(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.cyan, Colors.indigo],
                    ),
                  ),
                  width: 120,
                  height: 210,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          taskmodel!.day(),
                          style: GoogleFonts.gruppo(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 75),
                        ),
                        Text(
                          taskmodel!.month(),
                          style: GoogleFonts.gruppo(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              taskmodel!.releaseTimeFormatted(),
                              style: GoogleFonts.gruppo(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
