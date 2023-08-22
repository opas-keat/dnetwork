import 'dart:html';

import 'package:dio/dio.dart';
import 'package:frontend/app/api/api.dart';

import '../shared/utils.dart';
import 'custom_log_interceptor.dart';

ApiUtils apiUtils = ApiUtils();

class ApiUtils {
  static const title = "ApiUtils";
  static final ApiUtils _apiUtils = ApiUtils._i();
  static final _options = BaseOptions(
    baseUrl: Api.baseUrl,
    connectTimeout: const Duration(seconds: Api.connectionTimeout),
    receiveTimeout: const Duration(milliseconds: Api.receiveTimeout),
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );
  final Dio _dio = Dio(_options);

  ApiUtils._i() {
    _dio.interceptors.add(CustomLogInterceptor(
      requestHeader: false,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    ));
  }

  factory ApiUtils() {
    return _apiUtils;
  }

  Map<String, dynamic> header = {
    "Content-Type": "application/json; charset=utf-8"
  };

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=utf-8",
    "api-version": "1"
  };

  Map<String, String> secureHeaders = {
    "Content-Type": "application/json; charset=utf-8",
    "api-version": "1",
    "Authorization": ""
  };

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    // talker.debug(window.sessionStorage["token"]);
    // options!.headers?['Authorization'] =
    //     'Bearer: ${window.sessionStorage["token"]}';
    var opts = Options(
      headers: {
        "Authorization": 'Bearer ${window.sessionStorage["token"]}',
      },
    );
    var result = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: opts,
    );
    // talker.error(result);
    return result;
  }

  Future<Response> post({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    //Sending FormData:
    //FormData formData = FormData.fromMap({"name": ""});
    // options!.headers = secureHeaders;
    // options!.headers?['Authorization'] =
    //     'Bearer: ${window.sessionStorage["token"]}';
    var opts = Options(
      headers: {
        "Authorization": 'Bearer ${window.sessionStorage["token"]}',
      },
    );
    var result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: opts,
    );
    return result;
  }

  Future<Response> put({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    //Sending FormData:
    //FormData formData = FormData.fromMap({"name": ""});
    // options!.headers = secureHeaders;
    // options!.headers?['Authorization'] =
    //     'Bearer: ${window.sessionStorage["token"]}';
    var opts = Options(
      headers: {
        "Authorization": 'Bearer ${window.sessionStorage["token"]}',
      },
    );
    var result = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: opts,
    );
    return result;
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var opts = Options(
      headers: {
        "Authorization": 'Bearer ${window.sessionStorage["token"]}',
      },
    );
    var result = await _dio.delete(
      url,
      queryParameters: queryParameters,
      options: opts,
    );
    // talker.error(result);
    return result;
  }

  String handleError(dynamic error) {
    String errorDescription = "";

    talker.error(title, "handleError:: error >> $error");

    if (error is DioException) {
      talker.error(title,
          '************************ DioException ************************');

      DioException dioError = error;
      talker.error(title, 'dioException:: $dioError');
      if (dioError.response != null) {
        talker.error(title, "dioException:: response >> ${dioError.response}");
      }

      switch (dioError.type) {
        case DioExceptionType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioExceptionType.badCertificate:
          errorDescription = "badCertificate";
          break;
        case DioExceptionType.badResponse:
          errorDescription =
              "Received invalid status code: ${dioError.response?.statusCode} : ${dioError.response?.data['message']}";
          break;
        case DioExceptionType.connectionError:
          errorDescription = "Unexpected error occured";
          break;
        case DioExceptionType.unknown:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    talker.error(title, "handleError:: errorDescription >> $errorDescription");
    return errorDescription;
  }

  getFormattedError() {
    return {"error": "Error"};
  }

  getNetworkError() {
    return "No Internet Connection.";
  }
}
