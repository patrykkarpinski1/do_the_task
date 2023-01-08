import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class AddTasksPageContent extends StatefulWidget {
  const AddTasksPageContent(
      {Key? key, this.selectedDateFormatted, this.selectedTimeFormatted})
      : super(key: key);

  final String? selectedDateFormatted;
  final String? selectedTimeFormatted;

  @override
  State<AddTasksPageContent> createState() => _AddTasksPageContentState();
}

class _AddTasksPageContentState extends State<AddTasksPageContent> {
  String dropdownvalue = 'WORK';
  var items = [
    'WORK',
    'HOME',
    'SPORT WORKOUTS',
    'FEES',
    'FAMILY',
    'ENTERTAINMENT',
    'SHOPING',
    'LEARNING',
    'OTHER TASKS',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 171, 175),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        children: [
          const SizedBox(
            height: 20,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 49, 171, 175),
              borderRadius: BorderRadius.circular(5),
              boxShadow: const <BoxShadow>[
                BoxShadow(blurRadius: 1),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: DropdownButton(
                style: Theme.of(context).textTheme.titleMedium,
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
                isExpanded: true,
                underline: Container(),
                dropdownColor: const Color.fromARGB(255, 49, 171, 175),
                iconEnabledColor: const Color.fromARGB(255, 247, 143, 15),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const TextField(
            maxLength: 1000,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'co chcesz zrobić',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(
                  const Duration(
                    days: 365 * 10,
                  ),
                ),
              );
              (selectedDate);
            },
            child: const Text('Select a date'),
          ),
          ElevatedButton(
            child: const Text('Select a time'),
            onPressed: () async {
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                cancelText: "Cancel",
                confirmText: "Save",
                helpText: "Select time",
              );
              (selectedTime);
            },
          ),
        ],
      ),
    );
  }
}
