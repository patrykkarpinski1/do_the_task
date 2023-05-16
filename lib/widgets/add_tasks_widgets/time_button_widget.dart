import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/models/category_model.dart';

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
          Icons.schedule,
          color: Color.fromARGB(255, 56, 55, 55),
        ),
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
        label: Text(
          selectedTimeFormatted ?? 'Select a Time',
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
