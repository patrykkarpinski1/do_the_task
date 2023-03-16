import 'package:bloc/bloc.dart';
import 'package:modyfikacja_aplikacja/app/core/enums.dart';
import 'package:modyfikacja_aplikacja/models/chack_norris_model.dart';
import 'package:modyfikacja_aplikacja/repositories/chack_norris_repositories.dart';

part 'chack_norris_state.dart';

class ChackNorrisCubit extends Cubit<ChackNorrisState> {
  ChackNorrisCubit(this._chackNorrisRepository)
      : super(const ChackNorrisState());
  final ChackNorrisRepository _chackNorrisRepository;

  Future<void> getChackNorrisModel({
    required String joke,
  }) async {
    emit(const ChackNorrisState(status: Status.loading));
    try {
      final weatherModel = await _chackNorrisRepository.getChackNorrisModel(
        joke: joke,
      );
      emit(
        ChackNorrisState(
          model: weatherModel,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(
        ChackNorrisState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
