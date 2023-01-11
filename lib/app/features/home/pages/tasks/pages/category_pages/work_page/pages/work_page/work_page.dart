import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_pages/work_page/cubit/work_cubit.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/pages/category_pages/work_page/pages/add_work_task/add_work_task_page.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({
    Key? key,
  }) : super(key: key);

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
          'WORK',
          style: GoogleFonts.rubikBeastly(
            color: const Color.fromARGB(255, 247, 143, 15),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 1, 100, 146),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddWorkTask(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 247, 143, 15),
        ),
      ),
      body: BlocProvider(
        create: (context) => WorkCubit(ItemsRepository())..start(),
        child: BlocBuilder<WorkCubit, WorkState>(
          builder: (context, state) {
            final taskModels = state.tasks;
            if (taskModels.isEmpty) {
              return const SizedBox.shrink();
            }
            return ListView(
              children: [
                for (final taskModel in taskModels) ...[
                  WorkTasks(
                    taskModel: taskModel,
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

class WorkTasks extends StatelessWidget {
  const WorkTasks({
    required this.taskModel,
    Key? key,
  }) : super(key: key);
  final TaskModel taskModel;

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
                      taskModel.text,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 120,
                    color: const Color.fromARGB(255, 49, 171, 175),
                    child: Text(
                      taskModel.releaseDate.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  IconButton(
                    onPressed: () {
                      context
                          .read<WorkCubit>()
                          .remove(documentID: taskModel.id);
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
