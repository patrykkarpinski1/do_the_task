import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/app/features/home/pages/category_page/menu_pages/chack_norris/cubit/chack_norris_cubit.dart';
import 'package:modyfikacja_aplikacja/data/remote_data_sources/chack_norris_data_source.dart';
import 'package:modyfikacja_aplikacja/models/chack_norris_model.dart';
import 'package:modyfikacja_aplikacja/repositories/chack_norris_repositories.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ChackNorrisPage extends StatelessWidget {
  const ChackNorrisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChackNorrisCubit(ChackNorrisRepository(ChackNorrisDataSource())),
      child: BlocConsumer<ChackNorrisCubit, ChackNorrisState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            final errorMessage = state.errorMessage ?? 'Unkown error';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final chackNorrisModel = state.model;
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 208, 225, 234),
            appBar: NewGradientAppBar(
              gradient: const LinearGradient(
                colors: [Colors.cyan, Colors.indigo],
              ),
              title: Text(
                'JOKE',
                style: GoogleFonts.arimo(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 56, 55, 55),
                ),
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Image(
                        image: NetworkImage(
                            'https://api.chucknorris.io/img/chucknorris_logo_coloured_small@2x.png')),
                    const SizedBox(
                      height: 40,
                    ),
                    if (chackNorrisModel != null)
                      Builder(builder: (context) {
                        if (state.status == Status.loading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return JokeWidget(chackNorrisModel: chackNorrisModel);
                      }),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ChackNorrisCubit>().getChackNorrisModel(
                              joke: '',
                            );
                      },
                      child: const Text('Get joke'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class JokeWidget extends StatelessWidget {
  const JokeWidget({
    required this.chackNorrisModel,
    Key? key,
  }) : super(key: key);
  final ChackNorrisModel chackNorrisModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChackNorrisCubit, ChackNorrisState>(
      builder: (context, state) {
        return Center(child: Text(chackNorrisModel.joke));
      },
    );
  }
}
