import 'package:dio/dio.dart';

class ChackNorrisDataSource {
  Future<Map<String, dynamic>?> getChackNorrisData({
    required String joke,
  }) async {
    try {
      final response = await Dio()
          .get<Map<String, dynamic>>('https://api.chucknorris.io/jokes/random');
      return response.data;
    } on DioError catch (error) {
      throw Exception(
          error.response?.data['error']['message'] ?? 'Unkown error');
    }
  }
}
