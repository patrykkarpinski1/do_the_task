import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';

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
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(55),
      ),
      child: DropdownButtonFormField(
        borderRadius: BorderRadius.circular(55),
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Color.fromARGB(255, 56, 55, 55),
        ),
        value: selectedValue,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(55),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(55),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 2, 0, 0))),
          prefixIcon: const Icon(
            Icons.task_alt,
            color: Color.fromARGB(255, 56, 55, 55),
          ),
          labelText: 'Choose Category',
          labelStyle: GoogleFonts.arimo(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 56, 55, 55),
          ),
        ),
        dropdownColor: const Color.fromARGB(255, 208, 225, 234),
        items: widget.categoriesList.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value.title,
              style: GoogleFonts.arimo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 56, 55, 55),
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          widget.onValueChanged(value!.id);
        },
      ),
    );
  }
}
