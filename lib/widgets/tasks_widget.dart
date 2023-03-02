import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/features/detalis/pages/detalis_task_widget_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/tasks_pages/cubit/task_cubit.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

class TasksWidget extends StatelessWidget {
  const TasksWidget({
    required this.categoryId,
    this.taskmodel,
    Key? key,
  }) : super(key: key);
  final TaskModel? taskmodel;
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
                    child: _TasksWidget(taskmodel: taskModel)),
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
      padding: const EdgeInsets.only(
        top: 4,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 10),
                      width: 230,
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
                          borderRadius: BorderRadius.circular(55),
                        ),
                        width: 150,
                        height: 30,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(142, 15, 193, 107)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(55),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetalisTasksWidget(id: taskmodel!.id),
                                ),
                              );
                            },
                            child: Text(
                              'Read',
                              style: GoogleFonts.gruppo(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )))
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Column(
                  children: [
                    Container(
                      width: 130,
                      height: 210,
                      color: const Color.fromARGB(142, 15, 193, 107),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              taskmodel!.releaseDateFormatted(),
                              style: GoogleFonts.gruppo(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 75),
                            ),
                            Text(
                              taskmodel!.releaseDateFormatted2(),
                              style: GoogleFonts.gruppo(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            const SizedBox(height: 60),
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
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
