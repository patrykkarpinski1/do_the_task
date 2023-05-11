import 'package:do_the_task/app/dark_theme/dark_theme_preference.dart';
import 'package:do_the_task/app/dark_theme/dark_theme_provider.dart';
import 'package:do_the_task/widgets/dark_mode_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/features/home/pages/category_page/menu_pages/photo_note/photo_note_page.dart';

class DrawerMenuWidget extends StatefulWidget {
  const DrawerMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerMenuWidget> createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget> {
  late DarkThemePreference darkThemePreference;
  bool switchValue = false;

  @override
  void initState() {
    super.initState();
    switchValue =
        Provider.of<DarkThemeProvider>(context, listen: false).darkTheme;
  }

  void darkModeSwitch(bool value) {
    setState(() {
      switchValue = value;
    });
    Provider.of<DarkThemeProvider>(context, listen: false).darkTheme = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).focusColor,
            Theme.of(context).bottomAppBarColor,
          ],
        ),
      ),
      child: ListView(
        children: [
          DrawerHeader(
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
                const SizedBox(
                  height: 65,
                ),
                Row(
                  children: [
                    DarkModeWidget(
                      initialValue: switchValue,
                      onChanged: darkModeSwitch,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: Text(
                        'DARK MODE',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: const Color.fromARGB(255, 56, 55, 55),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PhotoNotePage(),
                ),
              );
            },
            leading: const Icon(
              Icons.photo_camera,
              color: Color.fromARGB(255, 56, 55, 55),
            ),
            title: Text(
              'PHOTO NOTE',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: const Color.fromARGB(255, 56, 55, 55),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 56, 55, 55),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
            title: Text(
              'CLOSE',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: const Color.fromARGB(255, 56, 55, 55),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
