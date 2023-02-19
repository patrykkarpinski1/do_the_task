import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/add_tasks/cubit/add_task_cubit.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/add_tasks/pages/proba2/proba_page.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

class AddTasksPageContent extends StatefulWidget {
  const AddTasksPageContent({
    super.key,
  });

  @override
  State<AddTasksPageContent> createState() => _AddTasksPageContentState();
}

String dropdownvalue = 'WORK';
var items = [
  'WORK',
  'HOME',
  'SPORT WORKOUTS',
  'FEES',
  'FAMILY',
  'ENTERTAINMENT',
  'SHOPPING',
  'LEARNING',
  'OTHER TASKS',
];

class _AddTasksPageContentState extends State<AddTasksPageContent> {
  DateTime? releaseDate;
  TimeOfDay? releaseTime;
  String? onValueChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTaskCubit(ItemsRepository())..start(),
      child: BlocBuilder<AddTaskCubit, AddTaskState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 49, 171, 175),
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    context
                        .read<AddTaskCubit>()
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
              onValueChanged: (newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
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
              selectedDateFormatted: releaseDate == null
                  ? null
                  : DateFormat.yMMMMEEEEd().format(releaseDate!),
            ),
          );
        },
      ),
    );
  }
}

class AddWidget extends StatefulWidget {
  const AddWidget({
    required this.onValueChanged,
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
  final void Function(String?)? onValueChanged;

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 49, 171, 175),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const <BoxShadow>[
              BoxShadow(blurRadius: 1),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: DropdownButton(
              items: items.map((itemsname) {
                return DropdownMenuItem(
                  value: itemsname,
                  child: Text(itemsname),
                );
              }).toList(),
              onChanged: widget.onValueChanged,
              value: dropdownvalue,
              isExpanded: true,
              underline: Container(),
              dropdownColor: const Color.fromARGB(255, 49, 171, 175),
              iconEnabledColor: const Color.fromARGB(255, 247, 143, 15),
            ),
          ),
        ),
        TextField(
          maxLength: 1000,
          maxLines: 10,
          decoration: const InputDecoration(
            hintText: 'co chcesz zrobić',
            border: OutlineInputBorder(),
          ),
          onChanged: (newTextNote) {
            context.read<AddTaskCubit>().changetextNote(newTextNote);
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
            widget.onTimeChanged(selectedTime);
          },
          child: Text(widget.selectedTimeFormatted ?? 'Select a Time'),
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
            widget.onDateChanged(selectedDate);
          },
          child: Text(widget.selectedDateFormatted ?? 'Select a date'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AddTasksPageContent2(),
              ),
            );
          },
          child: const Text("Próba"),
        ),
      ],
    );
  }
}
