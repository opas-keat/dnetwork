import 'package:dio/dio.dart';
import 'package:frontend/main.dart';

import 'custom_log_interceptor.dart';

ApiUtils apiUtils = ApiUtils();

class ApiUtils {
  static const title = "ApiUtils";
  static final ApiUtils _apiUtils = ApiUtils._i();
  final Dio _dio = Dio();

  ApiUtils._i() {
    _dio.interceptors.add(CustomLogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    ));
  }

  factory ApiUtils() {
    return _apiUtils;
  }

  Map<String, String> header = {"Content-Type": "application/json"};

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "api-version": "1"
  };

  Map<String, String> secureHeaders = {
    "Content-Type": "application/json",
    "api-version": "1",
    "Authorization": ""
  };

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var result = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
    );
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

    var result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  String handleError(dynamic error) {
    String errorDescription = "";

    talker.error(title, "handleError:: error >> $error");

    if (error is DioError) {
      talker.error(
          title, '************************ DioError ************************');

      DioError dioError = error;
      talker.error(title, 'dioError:: $dioError');
      if (dioError.response != null) {
        talker.error(
            title, "dioError:: response >> ${dioError.response}");
      }

      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
        case DioErrorType.connectionTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.badCertificate:
          errorDescription = "badCertificate";
          break;
        case DioErrorType.badResponse:
          errorDescription =
              "Received invalid status code: ${dioError.response?.statusCode} : ${dioError.response?.data['message']}";
          break;
        case DioErrorType.connectionError:
          errorDescription = "Unexpected error occured";
          break;
        case DioErrorType.unknown:
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
    return {'error': 'Error'};
  }

  getNetworkError() {
    return "No Internet Connection.";
  }
}
