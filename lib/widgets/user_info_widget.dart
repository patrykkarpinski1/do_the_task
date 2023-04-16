import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/cubit/auth_cubit.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  String? name;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text('Email Adress '),
            subtitle: Text(widget.user.email!),
            leading: const Icon(Icons.email_outlined),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: Color.fromARGB(255, 56, 55, 55),
              thickness: 0.8,
            ),
          ),
          InkWell(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(
                          child: Text(
                        'Add your name',
                        style: GoogleFonts.arimo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 56, 55, 55),
                        ),
                      )),
                      content: TextField(
                        onChanged: (newValue) {
                          setState(() {
                            name = newValue;
                          });
                        },
                      ),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              await context
                                  .read<AuthCubit>()
                                  .addUserName(name: name!);
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Save',
                              style: GoogleFonts.arimo(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 56, 55, 55),
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Exit',
                              style: GoogleFonts.arimo(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 56, 55, 55),
                              ),
                            ))
                      ],
                    );
                  });
            },
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state.user?.displayName != null) {
                  return ListTile(
                    title: const Text('User Name'),
                    subtitle: Text(state.user!.displayName!),
                    leading: const Icon(Icons.person),
                  );
                } else {
                  return const ListTile(
                    title: Text('User Name'),
                    subtitle: Text('Add Your Name'),
                    leading: Icon(Icons.person),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
