import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/requests/lectuter_service_request.dart';
import '../../data/responses/lectuter_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

class LectuterService {
  final title = "LectuterService";

  Future<LectuterServiceResponse?> createLectuter(
    List<Lectuters> listLectuters,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer ${window.sessionStorage["token"]}',
    // };
    talker.debug(LectuterServiceRequest(lectuters: listLectuters).toJson());
    try {
      final response = await apiUtils.post(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.lectuter,
        data: LectuterServiceRequest(lectuters: listLectuters),
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      LectuterServiceResponse lectuterServiceResponse =
          LectuterServiceResponse.fromJson(jsonDecode(response.toString()));
      talker.debug('code:: ${lectuterServiceResponse.code}');
      if (lectuterServiceResponse.code == "000") {
        return LectuterServiceResponse(
          code: lectuterServiceResponse.code,
          message: response.data["message"],
          data: lectuterServiceResponse.data,
        );
      }
      return LectuterServiceResponse.withError(
          code: CODE_RESPONSE_NULL, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return LectuterServiceResponse.withError(
          code: CODE_ERROR, msg: apiUtils.handleError(e));
    }
  }

  Future<LectuterServiceResponse?> listLectuter(
    Map<String, String> qParams,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
    // };
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
