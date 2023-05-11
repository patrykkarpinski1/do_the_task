import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/core/enums.dart';
import '/app/injection_container.dart';
import '/features/home/my_account_page/my_account_page.dart';
import '/features/home/pages/category_page/cubit/category_page_cubit.dart';
import '/widgets/category_widget.dart';
import '/widgets/drawer_menu_widget.dart';
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
            appBar: NewGradientAppBar(
              automaticallyImplyLeading: false,
              gradient: LinearGradient(colors: [
                Theme.of(context).focusColor,
                Theme.of(context).bottomAppBarColor,
              ]),
              title: Builder(
                builder: (context) => Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.list,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                    Text(
                      'CHOOSE TASK CATEGORY',
                      style: GoogleFonts.arimo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyText1!.color,
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
                  icon: Icon(
                    Icons.person,
                    color: Theme.of(context).iconTheme.color,
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
