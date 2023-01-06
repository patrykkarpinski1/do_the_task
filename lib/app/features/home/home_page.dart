import 'package:flutter/material.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/check/pages/check_page/check_page_content.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/add_tasks/add_tasks_page_content.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/notebook/pages/notebook_page/notebook_page_content.dart';

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
          return const CheckPageContent();
        }
        if (currentIndex == 2) {
          return const NotebookPageContent();
        }
        return const AddTasksPageContent();
      }),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 247, 143, 15),
        unselectedItemColor: const Color.fromARGB(255, 172, 149, 149),
        backgroundColor: const Color.fromARGB(255, 1, 100, 146),
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.task,
              ),
              label: 'Add Tasks'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.check,
              ),
              label: 'Check'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.note,
              ),
              label: 'Notebook'),
        ],
      ),
    );
  }
}
