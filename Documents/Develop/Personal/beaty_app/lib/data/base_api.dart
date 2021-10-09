import 'package:dio/dio.dart';

class BaseApi {
  static final String apiUrl = 'https://jsonplaceholder.typicode.com/';

  static BaseOptions opts = BaseOptions(
    baseUrl: apiUrl,
    responseType: ResponseType.json,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  static dynamic authInterceptor(RequestOptions options) async {
    const token = '';
    options.headers.addAll({"Authorization": "Bearer: $token"});
    return options;
  }

  static Dio _init() {
    return Dio(opts);
  }

  static final dio = _init();

  Future<Response> getHTTP(String url) async {
    try {
      final response = await dio.get(url);
      return response;
    } on DioError catch (e) {
      print("Error getting $url: ${e.stackTrace}");
      throw e;
    }
  }
}
