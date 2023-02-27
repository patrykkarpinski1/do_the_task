import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/tasks_pages/cubit/task_cubit.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

class FamilyPage extends StatelessWidget {
  const FamilyPage({
    this.categoryId,
    Key? key,
  }) : super(key: key);
  final int? categoryId;

  @override
  Widget build(BuildContext context) {
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
          'FAMILY',
          style: GoogleFonts.rubikBeastly(
            color: const Color.fromARGB(255, 247, 143, 15),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => TaskCubit(ItemsRepository())..getTasks(5),
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            final taskModels = state.tasks;
            if (taskModels.isEmpty) {
              return const SizedBox.shrink();
            }
            return ListView(
              children: [
                for (final taskModel in taskModels) ...[
                  FamilyTasks(
                    taskmodel: taskModel,
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class FamilyTasks extends StatelessWidget {
  const FamilyTasks({
    required this.taskmodel,
    Key? key,
  }) : super(key: key);
  final TaskModel taskmodel;

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
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 180,
                    height: 180,
                    color: const Color.fromARGB(255, 49, 171, 175),
                    child: Text(
                      taskmodel.text,
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
                        Text(taskmodel.releaseDateFormatted()),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          taskmodel.releaseTimeFormatted(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  IconButton(
                    onPressed: () {
                      context
                          .read<TaskCubit>()
                          .remove(documentID: taskmodel.id, categoryId: 5);
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
