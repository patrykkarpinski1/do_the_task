import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/cubit/auth_cubit.dart';
import 'package:modyfikacja_aplikacja/widgets/account_widget.dart';
import 'package:modyfikacja_aplikacja/widgets/user_info_widget.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({
    required this.user,
    Key? key,
  }) : super(key: key);
  final User user;

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
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
            appBar: NewGradientAppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 56, 55, 55),
                  )),
              gradient: const LinearGradient(
                colors: [Colors.cyan, Colors.indigo],
              ),
              title: Text(
                'ACCOUNT',
                style: GoogleFonts.arimo(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 56, 55, 55),
                ),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 208, 225, 234),
            body: ListView(
              padding: const EdgeInsets.all(15.0),
              children: [
                Builder(builder: (context) {
                  if (widget.user.photoURL == null) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                          child: image == null
                              ? const Image(image: AssetImage('images/man.png'))
                              : Image.file(File(image!.path)),
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  final pickedImage = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.gallery,
                                          maxHeight: 5000,
                                          maxWidth: 5000,
                                          imageQuality: 95);
                                  setState(() {
                                    image = pickedImage!;
                                  });
                                },
                                icon: const Icon(
                                  Icons.photo_library,
                                )),
                            IconButton(
                              onPressed: () async {
                                final pickedImage = await ImagePicker()
                                    .pickImage(
                                        source: ImageSource.camera,
                                        maxHeight: 5000,
                                        maxWidth: 5000,
                                        imageQuality: 95);
                                setState(() {
                                  image = pickedImage!;
                                });
                              },
                              icon: const Icon(Icons.camera_alt),
                            ),
                            Builder(builder: (context) {
                              if (image == null) {
                                return const SizedBox.shrink();
                              }
                              return TextButton(
                                  onPressed: () {
                                    context
                                        .read<AuthCubit>()
                                        .addUserPhoto(image: image!);
                                  },
                                  child: Text('Save',
                                      style: GoogleFonts.arimo(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: const Color.fromARGB(
                                            255, 56, 55, 55),
                                      )));
                            })
                          ],
                        )
                      ],
                    );
                  }
                  return FadeInImage(
                    placeholder: const AssetImage('images/man.png'),
                    height: 150,
                    image: NetworkImage(widget.user.photoURL!),
                  );
                }),
                const SizedBox(
                  height: 30,
                ),
                AccountWidget(user: widget.user),
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                          height: 60,
                          width: 50,
                          child: Divider(
                            thickness: 1,
                            color: Color.fromARGB(255, 56, 55, 55),
                          )),
                      Text(
                        '   Account Info   ',
                        style: GoogleFonts.arimo(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: const Color.fromARGB(255, 56, 55, 55),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                        width: 50,
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 56, 55, 55),
                        ),
                      ),
                    ],
                  ),
                ),
                UserInfoWidget(user: widget.user)
              ],
            ),
          );
        },
      ),
    );
  }
}
