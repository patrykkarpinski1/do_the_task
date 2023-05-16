import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '/app/cubit/auth_cubit.dart';

class UserPhotoWidget extends StatefulWidget {
  const UserPhotoWidget({super.key});

  @override
  State<UserPhotoWidget> createState() => _UserPhotoWidgetState();
}

class _UserPhotoWidgetState extends State<UserPhotoWidget> {
  XFile? image;
  var editing = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              editing = true;
            });
          },
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.user?.photoURL == null) {
                return SizedBox(
                  height: 150,
                  child: image == null
                      ? const Image(image: AssetImage('images/man.png'))
                      : Image.file(File(image!.path)),
                );
              } else {
                return Column(
                  children: [
                    FadeInImage(
                      placeholder: const AssetImage('images/man.png'),
                      height: 150,
                      image: NetworkImage(state.user!.photoURL!),
                    ),
                    if (editing == true) ...[
                      Text('current',
                          style: GoogleFonts.arimo(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          )),
                      Text('photo',
                          style: GoogleFonts.arimo(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          )),
                    ],
                  ],
                );
              }
            },
          ),
        ),
        if (editing == true) ...[
          Column(
            children: [
              IconButton(
                  onPressed: () async {
                    final pickedImage = await ImagePicker().pickImage(
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
                  final pickedImage = await ImagePicker().pickImage(
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
                      context.read<AuthCubit>().addUserPhoto(image: image!);

                      context.read<AuthCubit>().userReloded();
                      setState(() {
                        editing = false;
                      });
                    },
                    child: Text('Save',
                        style: GoogleFonts.arimo(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        )));
              })
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 150,
                child: image == null
                    ? const SizedBox.shrink()
                    : Image.file(File(image!.path)),
              ),
              Text('select photo',
                  style: GoogleFonts.arimo(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  )),
              Text('and save ',
                  style: GoogleFonts.arimo(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  )),
            ],
          )
        ],
      ],
    );
  }
}
