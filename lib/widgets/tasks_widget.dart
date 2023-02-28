import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modyfikacja_aplikacja/app/features/detalis/pages/detalis_task_widget_page.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/tasks_pages/cubit/task_cubit.dart';
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
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          final taskModels = state.tasks;
          if (taskModels.isEmpty) {
            return const SizedBox.shrink();
          }
          return ListView(
            children: [
              for (final taskModel in taskModels) ...[
                Dismissible(
                    key: ValueKey(taskModel.id),
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
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              DetalisTasksWidget(id: taskmodel!.id),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 180,
                      height: 180,
                      color: const Color.fromARGB(255, 49, 171, 175),
                      child: Text(
                        taskmodel!.text,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    width: 140,
                    color: const Color.fromARGB(255, 49, 171, 175),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(taskmodel!.releaseDateFormatted()),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          taskmodel!.releaseTimeFormatted(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<TaskCubit>().remove(
                            documentID: taskmodel!.id,
                          );
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
