import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/tasks/tasks_pages/pages/tasks_page.dart';
import 'package:modyfikacja_aplikacja/models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    required this.categoryModel,
    Key? key,
  }) : super(key: key);
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => TasksPage(id: categoryModel.id)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 5,
            right: 5,
            top: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(
                  image: AssetImage(categoryModel.images!),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  categoryModel.title,
                  style: GoogleFonts.arimo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
