import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/features/detalis/cubit/detalis_cubit.dart';
import 'package:modyfikacja_aplikacja/data/remote_data_sources/items_remote_data_source.dart';
import 'package:modyfikacja_aplikacja/models/task_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class DetalisTasksWidget extends StatelessWidget {
  const DetalisTasksWidget({
    this.taskModel,
    required this.id,
    Key? key,
  }) : super(key: key);
  final String id;
  final TaskModel? taskModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetalisCubit(ItemsRepository(ItemsRemoteDataSources()))
            ..getTaskWithID(id),
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
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.status == Status.success) {
            if (state.taskModel == null) {
              return const SizedBox.shrink();
            }
          }
          final taskModel = state.taskModel;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: NewGradientAppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 56, 55, 55),
                ),
              ),
              gradient:
                  const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
              title: Row(
                children: [
                  Text(
                    taskModel!.releaseDate.day.toString(),
                    style: GoogleFonts.gruppo(
                        color: const Color.fromARGB(255, 56, 55, 55),
                        fontWeight: FontWeight.bold,
                        fontSize: 36),
                  ),
                ],
              ),
            ),
            body: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    child: Text(
                      taskModel.releaseDate.day.toString(),
                      style: GoogleFonts.gruppo(
                          color: const Color.fromARGB(255, 56, 55, 55),
                          fontWeight: FontWeight.bold,
                          fontSize: 36),
                    ),
                  ),
                ),
                WorkTasks(
                  taskModel: taskModel,
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
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            taskModel.text,
          ),
        ),
      ),
    );
  }
}
