import 'package:flutter/material.dart';

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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35)),
          ),
          fillColor: Colors.white,
          filled: true),
      onChanged: onTextChanged,
    );
  }
}
