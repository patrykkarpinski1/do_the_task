import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/cubit/auth_cubit.dart';
import 'package:modyfikacja_aplikacja/features/home/pages/add_tasks/add_tasks_page_content.dart';
import 'package:modyfikacja_aplikacja/features/home/pages/notepad/pages/notepad_page_content.dart';
import 'pages/category_page/page/category_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.user,
    Key? key,
  }) : super(key: key);
  final User user;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..start(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.errorMessage),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 208, 225, 234),
            body: Builder(builder: (context) {
              if (currentIndex == 1) {
                return CategoryPageContent(
                  user: widget.user,
                );
              }
              if (currentIndex == 2) {
                return const NotepadPageContent();
              }
              return const AddTasksPageContent();
            }),
            bottomNavigationBar: FancyBottomNavigation(
              activeIconColor: const Color.fromARGB(255, 233, 210, 12),
              inactiveIconColor: const Color.fromARGB(255, 110, 109, 109),
              barBackgroundColor: const Color.fromARGB(255, 208, 225, 234),
              textColor: const Color.fromARGB(255, 110, 109, 109),
              initialSelection: currentIndex,
              onTabChangedListener: (newIndex) {
                setState(() {
                  currentIndex = newIndex;
                });
              },
              tabs: [
                TabData(iconData: Icons.add_task, title: "Add Tasks"),
                TabData(iconData: Icons.checklist, title: "Check"),
                TabData(iconData: Icons.note, title: "Notepad")
              ],
            ),
          );
        },
      ),
    );
  }
}
