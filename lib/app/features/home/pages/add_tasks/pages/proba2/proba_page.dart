import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/add_tasks/pages/proba2/cubit/proba_cubit.dart';
import 'package:modyfikacja_aplikacja/models/list/category_model2.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';

class AddTasksPageContent2 extends StatefulWidget {
  const AddTasksPageContent2({
    super.key,
  });

  @override
  State<AddTasksPageContent2> createState() => _AddTasksPageContent2();
}

class _AddTasksPageContent2 extends State<AddTasksPageContent2> {
  DateTime? releaseDate;
  TimeOfDay? releaseTime;
  String? selectedCategoryId;
  String? selectedDateFormatted;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProbaCubit(ItemsRepository())..start(),
      child: BlocListener<ProbaCubit, ProbaState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        child: BlocBuilder<ProbaCubit, ProbaState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Scaffold(
                backgroundColor: Color.fromARGB(255, 49, 171, 175),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 49, 171, 175),
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      if (selectedCategoryId != null && releaseDate != null) {
                        context.read<ProbaCubit>().add(state.textNote,
                            releaseDate!, releaseTime!, selectedCategoryId!);
                      } else {
                        //show snackbar
                      }
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Color.fromARGB(255, 247, 143, 15),
                    ),
                  ),
                ],
                backgroundColor: const Color.fromARGB(255, 1, 100, 146),
                title: Text(
                  'Probny ekran',
                  style: GoogleFonts.rubikBeastly(
                    color: const Color.fromARGB(255, 247, 143, 15),
                  ),
                ),
              ),
              body: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                children: [
                  const TextFieldWidget(),
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
                  BlocBuilder<ProbaCubit, ProbaState>(
                      // StreamBuilder<QuerySnapshot>(
                      //     stream: FirebaseFirestore.instance
                      //         .collection('categories')
                      //         .orderBy('title')
                      //         .snapshots(),
                      builder: (context, snapshot) {
                    final categoryModels = state.categories;
                    if (state.isLoading) return Container();
                    // if (!snapshot.hasData) return Container();
                    //if (setDefaultList) {
                    //  itemsList = snapshot.data?.docs[0].get('title');
                    //}
                    // final categoriesList = snapshot.data?.docs
                    final categoriesList = snapshot.categories
                        .map(
                            (doc) => CategoryModel2(id: doc.id, title: doc.title
                                // ['title']
                                ))
                        .toList();
                    //     ??
                    // [];
                    return DropdownButtonWidget(
                      categoriesList: categoriesList,
                      onValueChanged: (newValue) {
                        // setState(() {
                        selectedCategoryId = newValue;
                        // });
                      },
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DropdownButtonWidget extends StatefulWidget {
  const DropdownButtonWidget({
    required this.categoriesList,
    required this.onValueChanged,
    this.categoryModels,
    Key? key,
  }) : super(key: key);
  final List<CategoryModel2> categoriesList;
  final void Function(String?) onValueChanged;
  final CategoryModel2? categoryModels;

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  CategoryModel2? selectedValue;

  @override
  Widget build(BuildContext context) {
    if (widget.categoriesList.isEmpty) {
      return Container();
    }
    // if (widget.categoriesList.isNotEmpty) ;
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
        child: DropdownButton<CategoryModel2>(
          value: selectedValue ?? widget.categoriesList.first,
          items: widget.categoriesList.map((value) {
            return DropdownMenuItem<CategoryModel2>(
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
          isExpanded: true,
          underline: Container(),
          dropdownColor: const Color.fromARGB(255, 49, 171, 175),
          iconEnabledColor: const Color.fromARGB(255, 247, 143, 15),
        ),
      ),
    );
  }
}

class TimeButtonWidget extends StatefulWidget {
  const TimeButtonWidget({
    this.categoryModels,
    required this.selectedTimeFormatted,
    required this.onTimeChanged,
    Key? key,
  }) : super(key: key);
  final CategoryModel2? categoryModels;
  final String? selectedTimeFormatted;
  final Function(TimeOfDay?) onTimeChanged;

  @override
  State<TimeButtonWidget> createState() => _TimeButtonWidgetState();
}

class _TimeButtonWidgetState extends State<TimeButtonWidget> {
  TimeOfDay? releaseTime;

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
        widget.onTimeChanged(selectedTime);
      },
      child: Text(widget.selectedTimeFormatted ?? 'Select a Time'),
    );
  }
}

class DateButtonWidget extends StatefulWidget {
  DateButtonWidget({
    Key? key,
    required this.onDateChanged,
    required this.selectedDateFormatted,
    this.categoryModels,
    this.releaseDate,
  }) : super(key: key);

  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;
  final CategoryModel2? categoryModels;
  DateTime? releaseDate;

  @override
  State<DateButtonWidget> createState() => _DateButtonWidgetState();
}

class _DateButtonWidgetState extends State<DateButtonWidget> {
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
        widget.onDateChanged(selectedDate);
      },
      child: Text(widget.selectedDateFormatted ?? 'Select a date'),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 1000,
      maxLines: 10,
      decoration: const InputDecoration(
        hintText: 'co chcesz zrobić',
        border: OutlineInputBorder(),
      ),
      onChanged: (newTextNote) {
        context.read<ProbaCubit>().changetextNote(newTextNote);
      },
    );
  }
}

// glowna classa Page // dont use setstate
// BlocProvider BlocBuilder Scaffold
// selected Values
// AppBar with + button
// Text
// Date
// Time
// Categorie

// each widget is stateful widget
// each keeps the selected value
//

// cubit only reads categories from the firebase (as Future not Stream)
// and saves new data
