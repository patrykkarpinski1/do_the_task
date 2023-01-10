import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/check/pages/category_pages/work_page/pages/add_work_task/cubit/add_work_task_cubit.dart';

class AddWorkTask extends StatefulWidget {
  const AddWorkTask({
    super.key,
  });

  @override
  State<AddWorkTask> createState() => _AddWorkTaskState();
}

class _AddWorkTaskState extends State<AddWorkTask> {
  DateTime? releaseDate;
  TimeOfDay? releaseTime;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddWorkTaskCubit()..start(),
      child: BlocBuilder<AddWorkTaskCubit, AddWorkTaskState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 49, 171, 175),
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    context
                        .read<AddWorkTaskCubit>()
                        .add(state.textNote, releaseDate!, releaseTime!);
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Color.fromARGB(255, 247, 143, 15),
                  ),
                ),
              ],
              backgroundColor: const Color.fromARGB(255, 1, 100, 146),
              title: Text(
                'ADD NEW TASKS',
                style: GoogleFonts.rubikBeastly(
                  color: const Color.fromARGB(255, 247, 143, 15),
                ),
              ),
            ),
            body: AddWidget(
              onTimeChanged: (newValue) {
                setState(() {
                  releaseTime = newValue;
                });
              },
              selectedTimeFormatted: releaseTime?.toString(),
              onDateChanged: (newValue) {
                setState(() {
                  releaseDate = newValue;
                });
              },
              selectedDateFormatted: releaseDate?.toIso8601String(),
            ),
          );
        },
      ),
    );
  }
}

class AddWidget extends StatelessWidget {
  const AddWidget({
    required this.selectedTimeFormatted,
    required this.onTimeChanged,
    required this.onDateChanged,
    required this.selectedDateFormatted,
    Key? key,
  }) : super(key: key);
  final String? selectedTimeFormatted;
  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;
  final Function(TimeOfDay?) onTimeChanged;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      children: [
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          maxLength: 1000,
          maxLines: 10,
          decoration: const InputDecoration(
            hintText: 'co chcesz zrobić',
            border: OutlineInputBorder(),
          ),
          onChanged: (newTextNote) {
            context.read<AddWorkTaskCubit>().changetextNote(newTextNote);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
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
        ),
        ElevatedButton(
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
        ),
      ],
    );
  }
}
