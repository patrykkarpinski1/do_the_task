import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    this.onPressed,
    Key? key,
  }) : super(key: key);
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).focusColor,
            Theme.of(context).bottomAppBarColor,
          ],
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
        onPressed: onPressed,
        child: Text(
          'Add Task',
          style: GoogleFonts.arimo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyText2!.color,
          ),
        ),
      ),
    );
  }
}
