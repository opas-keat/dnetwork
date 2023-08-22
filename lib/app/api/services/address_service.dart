import 'dart:convert';

import 'package:dio/dio.dart';

import '../../data/responses/address_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class AddressService {
  final title = "AddressService";

  Future<ProvinceServiceResponse?> listProvince() async {
    Map<String, dynamic> qParams = {
      "offset": 0,
      "limit": 100,
    };
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.provinces,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      ProvinceServiceResponse provinceServiceResponse =
          ProvinceServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("provinceServiceResponse $provinceServiceResponse");
      return provinceServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }

  Future<AmphureServiceResponse?> listAmphureByPCode(String pCode) async {
    try {
      final response = await apiUtils.get(
        url:
            '${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.amphures}/$pCode',
        // queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      AmphureServiceResponse amphureServiceResponse =
          AmphureServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("amphureServiceResponse $amphureServiceResponse");
      return amphureServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }

  Future<AmphureServiceResponse?> listAmphureByPName(String pName) async {
    try {
      final response = await apiUtils.get(
        url:
            '${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.amphures}?pName=$pName',
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      AmphureServiceResponse amphureServiceResponse =
          AmphureServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("amphureServiceResponse $amphureServiceResponse");
      return amphureServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }

  Future<TambolServiceResponse?> listTambolByACode(String aCode) async {
    try {
      final response = await apiUtils.get(
        url:
            '${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.tambols}/$aCode',
        // url: "http://localhost:9999/ectapi/v2/tambols/$aCode",
        // queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      TambolServiceResponse tambolServiceResponse =
          TambolServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("tambolServiceResponse $tambolServiceResponse");
      return tambolServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }

  Future<TambolServiceResponse?> listTambolByPNameAName(
      String pName, String aName) async {
    try {
      final response = await apiUtils.get(
        url:
            '${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.tambols}?pName=$pName&aName=$aName',
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      TambolServiceResponse tambolServiceResponse =
          TambolServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("amphureServiceResponse $amphureServiceResponse");
      return tambolServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}

// class Client {
//   Dio init() {
//     Dio _dio = Dio();
//     // _dio.options.baseUrl = "http://127.0.0.1:8080";
//     _dio.options.baseUrl = "https://d-network.ect.go.th";
//     _dio.options.connectTimeout =
//         const Duration(seconds: Api.connectionTimeout);
//     _dio.options.receiveTimeout =
//         const Duration(milliseconds: Api.receiveTimeout);
//     // _dio.options.contentType = Headers.jsonContentType;
//     _dio.interceptors.add(CustomInterceptors());
//     // Transform the response data to a String encoded with UTF8.
//     // The default value is [ResponseType.JSON].
//     return _dio;
//   }
// }

// class CustomInterceptors extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     String token = window.sessionStorage["token"].toString();
//     // print('REQUEST[${options.method}] => PATH: ${options.baseUrl}');
//     // print("token = " + token);
//     options.headers["Authorization"] = "Bearer " + token;
//     return super.onRequest(options, handler);
//   }

//   @override
//   dynamic onResponse(Response response, ResponseInterceptorHandler handler) {
//     // print(
//     // 'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
//     return super.onResponse(response, handler);
//   }

//   @override
//   dynamic onError(DioException err, ErrorInterceptorHandler handler) {
//     // print(
//     //     'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
//     return super.onError(err, handler);
//   }
// }

// class AddressService {
//   final title = "AddressService";
//   Dio _client;
//   AddressService(this._client);

//   Future<List<ProvinceServiceData>?> listProvince() async {
//     Map<String, dynamic> qParams = {
//       "offset": 0,
//       "limit": 100,
//     };
//     // final List<ProvinceServiceData> list;
//     try {
//       // final response = await apiUtils.get(
//       //   url: Api.masterApiContext +
//       //       Api.masterApiVersion +
//       //       ApiEndPoints.provinces,
//       //   // url: "https://jsonplaceholder.typicode.com/photos",
//       //   queryParameters: qParams,
//       // );
//       Response<String> response = await _client.get(
//         Api.masterApiContext + Api.masterApiVersion + ApiEndPoints.provinces,
//         queryParameters: qParams,
//       );
//       // final decodedData = jsonDecode(response.data.toString());
//       // print(result);
//       // final parsed =
//       //     jsonDecode(result.data.toString()).cast<Map<String, dynamic>>();
//       // List<ProvinceServiceData> list = parsed
//       //     .map<ProvinceServiceData>(
//       //         (json) => ProvinceServiceData.fromJson(json))
//       //     .toList();
//       // List<ProvinceServiceData> list = jsonDecode(result.data.toString())
//       //     .map((data) => ProvinceServiceData.fromMap(data))
//       //     .toList();
//       final decodedData = jsonDecode(response.data.toString());
//       // talker.debug("fff111 " + decodedData.toString());
//       List<ProvinceServiceData> list = List.from(decodedData)
//           .map<ProvinceServiceData>((item) => ProvinceServiceData.fromMap(item))
//           .toList();
//       // return list;
//       // talker.debug("fff " + list.toString());

//       return list;
//     } catch (e) {
//       talker.error(e);
//     }
//   }
// }
