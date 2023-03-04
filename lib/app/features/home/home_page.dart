import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/add_tasks/add_tasks_page_content.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/notepad/pages/notepad_page/notepad_page_content.dart';

import 'pages/category_page/page/category_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (currentIndex == 1) {
          return const CategoryPageContent();
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
  }
}
