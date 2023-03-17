import 'package:modyfikacja_aplikacja/data/remote_data_sources/chack_norris_data_source.dart';
import 'package:modyfikacja_aplikacja/models/chack_norris_model.dart';

class ChackNorrisRepository {
  ChackNorrisRepository(this.chackNorrisDataSource);
  final ChackNorrisDataSource chackNorrisDataSource;

  Future<ChackNorrisModel?> getChackNorrisModel({
    required String joke,
  }) async {
    final json = await chackNorrisDataSource.getChackNorrisData(joke: joke);
    if (json == null) {
      return null;
    }
    return ChackNorrisModel.fromJson(json);
  }
}
