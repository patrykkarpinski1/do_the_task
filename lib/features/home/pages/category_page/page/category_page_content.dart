import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/injection_container.dart';
import 'package:modyfikacja_aplikacja/features/home/my_account_page/my_account_page.dart';
import 'package:modyfikacja_aplikacja/features/home/pages/category_page/cubit/category_page_cubit.dart';
import 'package:modyfikacja_aplikacja/widgets/category_widget.dart';
import 'package:modyfikacja_aplikacja/widgets/drawer_menu_widget.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class CategoryPageContent extends StatelessWidget {
  const CategoryPageContent({
    required this.user,
    Key? key,
  }) : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryPageCubit>(
      create: (context) => getIt()..start(),
      child: BlocConsumer<CategoryPageCubit, CategoryPageState>(
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
          if (state.status == Status.initial) {
            return const Center(
              child: Text('Initial state'),
            );
          }
          if (state.status == Status.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.status == Status.success) {
            if (state.categories.isEmpty) {
              return const SizedBox.shrink();
            }
          }
          final categoryModels = state.categories;
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 208, 225, 234),
            appBar: NewGradientAppBar(
              automaticallyImplyLeading: false,
              gradient:
                  const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
              title: Builder(
                builder: (context) => Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.list,
                        color: Color.fromARGB(255, 56, 55, 55),
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                    Text(
                      'CHOOSE TASK CATEGORY',
                      style: GoogleFonts.arimo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 56, 55, 55),
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MyAccountPage(
                          user: user!,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 56, 55, 55),
                  ),
                ),
              ],
            ),
            drawer: const Drawer(
              child: DrawerMenuWidget(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                children: [
                  for (final categoryModel in categoryModels) ...[
                    CategoryWidget(categoryModel: categoryModel),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
