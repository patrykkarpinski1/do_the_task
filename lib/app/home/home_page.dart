import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          return const Center(
            child: Text('jeden'),
          );
        }
        if (currentIndex == 2) {
          return const Center(
            child: Text('dwa'),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('jesteś zalogowany jako ${widget.user.email}'),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text('Wyloguj się'),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Moje konto'),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Zadania'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Ustawienia'),
        ],
      ),
    );
  }
}
