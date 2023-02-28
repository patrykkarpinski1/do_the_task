import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/features/detalis/cubit/detalis_cubit.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

class DetalisTasksWidget extends StatelessWidget {
  const DetalisTasksWidget({
    required this.id,
    Key? key,
  }) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetalisCubit(ItemsRepository())..getTaskWithID(id),
      child: BlocConsumer<DetalisCubit, DetalisState>(
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
            if (state.taskModel == null) {
              return const SizedBox.shrink();
            }
          }
          final taskModel = state.taskModel;

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
            body: ListView(
              children: [
                WorkTasks(
                  taskModel: taskModel!,
                ),
              ],
            ),
          );
        },
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
