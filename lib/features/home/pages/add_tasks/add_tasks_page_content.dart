import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/injection_container.dart';
import 'package:modyfikacja_aplikacja/features/home/pages/add_tasks/cubit/add_task_cubit.dart';
import 'package:modyfikacja_aplikacja/widgets/add_task_button_widget.dart';
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
    return BlocProvider<AddTaskCubit>(
      create: (context) => getIt()..fetch(),
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
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
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
                      : DateFormat('dd MMMM yyyy').format(releaseDate!),
                ),
                const SizedBox(
                  height: 10,
                ),
                TimeButtonWidget(
                    selectedTimeFormatted: releaseTime?.format(context),
                    onTimeChanged: (newValue) {
                      setState(() {
                        releaseTime = newValue;
                      });
                    }),
                DropDownButtonWidget(
                    onValueChanged: (newValue) {
                      setState(() {
                        selectedCategoryId = newValue!;
                      });
                    },
                    categoriesList: categoriesList),
                const SizedBox(
                  height: 10,
                ),
                Builder(builder: (context) {
                  if (text == null ||
                      selectedCategoryId == null ||
                      releaseDate == null ||
                      releaseTime == null) {
                    return const SizedBox.shrink();
                  }
                  return AddTaskButton(
                    onPressed: () {
                      context.read<AddTaskCubit>().add(text!, releaseDate!,
                          releaseTime!, selectedCategoryId!);
                      setState(() {
                        releaseDate = null;
                        releaseTime = null;
                      });
                    },
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
