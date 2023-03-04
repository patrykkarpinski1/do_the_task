import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/add_tasks/cubit/add_task_cubit.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';
import 'package:modyfikacja_aplikacja/widgets/date_button_widget.dart';
import 'package:modyfikacja_aplikacja/widgets/drop_down_button_widget.dart';
import 'package:modyfikacja_aplikacja/widgets/text_field_widget.dart';
import 'package:modyfikacja_aplikacja/widgets/time_button_widget.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class AddTasksPageContent extends StatefulWidget {
  const AddTasksPageContent({
    super.key,
  });

  @override
  State<AddTasksPageContent> createState() => _AddTasksPageContentState();
}

class _AddTasksPageContentState extends State<AddTasksPageContent> {
  DateTime? releaseDate;
  TimeOfDay? releaseTime;
  String? selectedCategoryId;
  String? text;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTaskCubit(ItemsRepository())..start(),
      child: BlocConsumer<AddTaskCubit, AddTaskState>(
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
            if (state.categories.isEmpty) {
              return const SizedBox.shrink();
            }
          }
          final categoriesList = state.categories;
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 208, 225, 234),
            appBar: NewGradientAppBar(
              gradient:
                  const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
              title: Center(
                child: Text(
                  'ADD NEW TASKS',
                  style: GoogleFonts.arimo(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 56, 55, 55),
                  ),
                ),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              children: [
                TextFieldWidget(
                  onTextChanged: (newValue) {
                    setState(() {
                      text = newValue;
                    });
                  },
                ),
                DateButtonWidget(
                  onDateChanged: (newValue) {
                    setState(() {
                      releaseDate = newValue;
                    });
                  },
                  selectedDateFormatted: releaseDate == null
                      ? null
                      : DateFormat.yMMMMEEEEd().format(releaseDate!),
                ),
                const SizedBox(
                  height: 10,
                ),
                TimeButtonWidget(
                    selectedTimeFormatted: releaseTime?.toString(),
                    onTimeChanged: (newValue) {
                      setState(() {
                        releaseTime = newValue;
                      });
                    }),
                DropDownButtonWidget(
                    onValueChanged: (newValue) {
                      selectedCategoryId = newValue!;
                    },
                    categoriesList: categoriesList),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: text == null ||
                          releaseTime == null ||
                          releaseDate == null ||
                          selectedCategoryId == null
                      ? null
                      : Container(
                          width: 150,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.cyan, Colors.indigo],
                            ),
                            borderRadius: BorderRadius.circular(55),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(55),
                              ),
                            ),
                            onPressed: () {
                              context.read<AddTaskCubit>().add(
                                  text!,
                                  releaseDate!,
                                  releaseTime!,
                                  selectedCategoryId!);
                            },
                            child: Text(
                              'Add Task',
                              style: GoogleFonts.arimo(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 56, 55, 55),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
