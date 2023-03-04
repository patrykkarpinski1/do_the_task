import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerMenuWidget extends StatelessWidget {
  const DrawerMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.cyan, Colors.indigo],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/blue.jpg'), fit: BoxFit.fill),
            ),
            child: Column(
              children: [
                Text(
                  'M E N U',
                  style: GoogleFonts.gruppo(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: const Color.fromARGB(255, 56, 55, 55),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.photo_camera),
            title: const Text('PHOTO NOTE'),
          ),
          ListTile(
            onTap: () {},
            title: const Text('REST API'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.restaurant_menu),
            title: const Text('MEAL FOR DAY'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.task),
            title: const Text('TASKS FOR TODAY '),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.today_sharp),
            title: const Text('TASKS FOR WEEK '),
          ),
          ListTile(
            leading: const Icon(Icons.arrow_back),
            onTap: () {
              Navigator.of(context).pop();
            },
            title: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }
}
