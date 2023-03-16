import 'package:dio/dio.dart';

class ChackNorrisDataSource {
  Future<Map<String, dynamic>?> getChackNorrisData({
    required String joke,
  }) async {
    final response = await Dio()
        .get<Map<String, dynamic>>('https://api.chucknorris.io/jokes/random');
    return response.data;
  }
}
