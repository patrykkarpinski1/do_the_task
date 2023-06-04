import 'package:do_the_task/app/encryption.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/core/enums.dart';
import '/app/injection_container.dart';
import '/features/detalis/cubit/detalis_cubit.dart';
import '/models/task_model.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class DetalisTasksPage extends StatelessWidget {
  const DetalisTasksPage({
    this.taskModel,
    required this.id,
    Key? key,
  }) : super(key: key);
  final String id;
  final TaskModel? taskModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetalisCubit>(
      create: (context) => getIt()..getTaskWithID(id),
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
              title: Row(
                children: [
                  Text(
                    taskModel?.dayFullName() ?? 'Unkown',
                    style: GoogleFonts.gruppo(
                        color: Theme.of(context).textTheme.bodyText1!.color,
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
                      taskModel?.releaseTimeFormatted() ?? 'Unkown',
                      style: GoogleFonts.gruppo(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 36),
                    ),
                  ),
                ),
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
    String encryptedText = MyEncryptionDecription.decryptWithAESKey(
      taskModel.text,
    );
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            encryptedText,
            style: GoogleFonts.arimo(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ),
      ),
    );
  }
}
