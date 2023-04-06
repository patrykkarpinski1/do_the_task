import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modyfikacja_aplikacja/features/home/pages/category_page/menu_pages/photo_note/cubit/photo_note_cubit.dart';
import 'dart:io';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../app/core/enums.dart';

class AddPhotoPage extends StatefulWidget {
  const AddPhotoPage({super.key});

  @override
  State<AddPhotoPage> createState() => _AddPhotoPageState();
}

class _AddPhotoPageState extends State<AddPhotoPage> {
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotoNoteCubit, PhotoNoteState>(
      listener: (context, state) {
        if (state.saved) {
          context.read<PhotoNoteCubit>().start();
          Navigator.of(context).pop();
        }
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
        return Scaffold(
            appBar: NewGradientAppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<PhotoNoteCubit>().add(image!);
                    },
                    icon: const Icon(
                      Icons.save_as_outlined,
                      color: Color.fromARGB(255, 56, 55, 55),
                    ))
              ],
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 56, 55, 55),
                ),
              ),
              gradient: const LinearGradient(
                colors: [Colors.cyan, Colors.indigo],
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 208, 225, 234),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.cyan, Colors.indigo],
                    ),
                    borderRadius: BorderRadius.circular(55),
                  ),
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    onPressed: () async {
                      final pickedImage = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          maxHeight: 4800,
                          maxWidth: 2600,
                          imageQuality: 95);
                      setState(() {
                        image = pickedImage!;
                      });
                    },
                    child: const Icon(
                      Icons.photo_library,
                      color: Color.fromARGB(255, 56, 55, 55),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.cyan, Colors.indigo],
                      ),
                      borderRadius: BorderRadius.circular(55),
                    ),
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      onPressed: () async {
                        final pickedImage = await ImagePicker().pickImage(
                            source: ImageSource.camera,
                            maxHeight: 4800,
                            maxWidth: 2600,
                            imageQuality: 95);
                        setState(() {
                          image = pickedImage!;
                        });
                      },
                      child: const Icon(
                        Icons.camera_alt,
                        color: Color.fromARGB(255, 56, 55, 55),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: image == null ? null : Image.file(File(image!.path)),
                ),
              ],
            ));
      },
    );
  }
}
