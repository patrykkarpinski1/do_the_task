import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modyfikacja_aplikacja/app/features/home/check/check_page_content.dart';
import 'package:modyfikacja_aplikacja/app/features/home/my_account/my_account_page_content.dart';
import 'package:modyfikacja_aplikacja/app/features/home/settings/setting_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

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
          return const SettingsPageContent();
        }
        return MyAccountPageContent(widget: widget);
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
                Icons.person,
              ),
              label: 'My Account'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.check,
              ),
              label: 'Check'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: 'Settings'),
        ],
      ),
    );
  }
}
