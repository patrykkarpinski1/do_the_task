import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/add_tasks/cubit/add_task_cubit.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';
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
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<AddTaskCubit>().add(
                        text!, releaseDate!, releaseTime!, selectedCategoryId!);
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Color.fromARGB(255, 56, 55, 55),
                  ),
                ),
              ],
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
              ],
            ),
          );
        },
      ),
    );
  }
}

class DropDownButtonWidget extends StatefulWidget {
  const DropDownButtonWidget({
    required this.onValueChanged,
    required this.categoriesList,
    this.categoryModels,
    Key? key,
  }) : super(key: key);
  final void Function(String?) onValueChanged;
  final List<CategoryModel> categoriesList;
  final CategoryModel? categoryModels;

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonWidget();
}

class _DropDownButtonWidget extends State<DropDownButtonWidget> {
  CategoryModel? selectedValue;
  @override
  Widget build(BuildContext context) {
    if (widget.categoriesList.isEmpty) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 49, 171, 175),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const <BoxShadow>[
            BoxShadow(blurRadius: 1),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 49, 171, 175),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const <BoxShadow>[
          BoxShadow(blurRadius: 1),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: DropdownButton<CategoryModel>(
          items: widget.categoriesList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value.title),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              widget.onValueChanged(value.id);
            }
            setState(() {
              selectedValue = value;
            });
          },
          value: selectedValue ?? widget.categoriesList.first,
          isExpanded: true,
          underline: Container(),
          dropdownColor: const Color.fromARGB(255, 49, 171, 175),
          iconEnabledColor: const Color.fromARGB(255, 247, 143, 15),
        ),
      ),
    );
  }
}

class TimeButtonWidget extends StatelessWidget {
  const TimeButtonWidget({
    this.categoryModels,
    required this.selectedTimeFormatted,
    required this.onTimeChanged,
    Key? key,
  }) : super(key: key);
  final CategoryModel? categoryModels;
  final String? selectedTimeFormatted;
  final Function(TimeOfDay?) onTimeChanged;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          cancelText: "Cancel",
          confirmText: "Save",
          helpText: "Select time",
        );
        onTimeChanged(selectedTime);
      },
      child: Text(selectedTimeFormatted ?? 'Select a Time'),
    );
  }
}

class DateButtonWidget extends StatelessWidget {
  const DateButtonWidget({
    Key? key,
    required this.onDateChanged,
    required this.selectedDateFormatted,
    this.categoryModels,
  }) : super(key: key);

  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;
  final CategoryModel? categoryModels;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(days: 365 * 10),
          ),
        );
        onDateChanged(selectedDate);
      },
      child: Text(selectedDateFormatted ?? 'Select a date'),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    required this.onTextChanged,
    Key? key,
  }) : super(key: key);
  final Function(String) onTextChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 2000,
      maxLines: 10,
      decoration: const InputDecoration(
        hintText: 'co chcesz zrobić',
        border: OutlineInputBorder(),
      ),
      onChanged: onTextChanged,
    );
  }
}
