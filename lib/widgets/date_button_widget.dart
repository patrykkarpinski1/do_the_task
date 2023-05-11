import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/models/category_model.dart';

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
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55),
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(55),
          ),
        ),
        icon: const Icon(
          Icons.edit_calendar_outlined,
          color: Color.fromARGB(255, 56, 55, 55),
        ),
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
        label: Text(
          selectedDateFormatted ?? 'Select a date',
          style: GoogleFonts.arimo(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 56, 55, 55),
          ),
        ),
      ),
    );
  }
}
