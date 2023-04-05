import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modyfikacja_aplikacja/app/cubit/auth_cubit.dart';
import 'package:modyfikacja_aplikacja/features/home/my_account_page/add_user_name_page.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

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
            subtitle: Text(user.email!),
            leading: const Icon(Icons.email_outlined),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: Color.fromARGB(255, 56, 55, 55),
              thickness: 0.8,
            ),
          ),
          Builder(builder: (context) {
            if (user.displayName == null) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                            value: context.read<AuthCubit>(),
                            child: const AddUserNamePage(),
                          )));
                },
                child: const ListTile(
                  title: Text('User Name'),
                  subtitle: Text('Add Your Name'),
                  leading: Icon(Icons.person),
                ),
              );
            }
            return ListTile(
              title: const Text('User Name'),
              subtitle: Text(user.displayName!),
              leading: const Icon(Icons.person),
            );
          }),
        ],
      ),
    );
  }
}
