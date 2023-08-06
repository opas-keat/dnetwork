import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/lectuter_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class LectuterService {
  final title = "LectuterService";

  Future<LectuterServiceResponse?> listLectuter(
    String province,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
    // };
    Map<String, String> qParams = {
      "offset": "0",
      "limit": "20",
      "order": "created_at",
      "province": province,
    };
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.lectuter,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      LectuterServiceResponse lectuterServiceResponse =
          LectuterServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("lectuterServiceResponse $lectuterServiceResponse");
      return lectuterServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
