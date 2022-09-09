import 'package:dio/dio.dart';

class MyInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.queryParameters['id'] != null &&
        options.queryParameters['id'] % 2 == 0) {
      options.queryParameters['id'] *= 2;
    }

    await Future.delayed(
      Duration(seconds: 2),
    );

    super.onRequest(options, handler);
  }
}

class Network {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com/',
    ),
  );

  Network() {
    _dio.interceptors.add(MyInterceptor());
  }

  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      _dio.get(
        path,
        queryParameters: queryParameters,
      );
}
