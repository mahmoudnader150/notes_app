import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'http://127.0.0.1:8000/',
          receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
  }) async
  {
    return await dio.get(
      url,
    );
  }


  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
  }) async
  {
    dio.options.headers =
    {
      'lang': lang,
      'Content-Type': 'application/json',
    };

    return dio.post(
      url,
      data: data,
    );
  }
}
