import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/category_page/menu_pages/photo_note/cubit/photo_note_cubit.dart';
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class PhotoNotePage extends StatelessWidget {
  const PhotoNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
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
        title: Text(
          'PHOTO NOTE',
          style: GoogleFonts.arimo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 56, 55, 55),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => PhotoNoteCubit(ItemsRepository())..start(),
        child: BlocConsumer<PhotoNoteCubit, PhotoNoteState>(
          listener: (context, state) {
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
            final photoModels = state.photos;
            if (state.status == Status.initial) {
              return const Center(
                child: Text('Initial state'),
              );
            }
            if (state.status == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // if (state.status == Status.success) {
            //   if (photoModels.isEmpty) {
            //     return const SizedBox.shrink();
            //   }
            // }
            return GridView(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                children: const [Card()]);
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.cyan, Colors.indigo],
                ),
                borderRadius: BorderRadius.circular(55),
              ),
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                onPressed: () {},
                child: const Icon(
                  Icons.photo_library,
                  color: Color.fromARGB(255, 56, 55, 55),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.cyan, Colors.indigo],
              ),
              borderRadius: BorderRadius.circular(55),
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {},
              child: const Icon(
                Icons.camera_alt,
                color: Color.fromARGB(255, 56, 55, 55),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 208, 225, 234),
    );
  }
}
