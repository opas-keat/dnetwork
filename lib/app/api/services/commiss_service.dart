import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';

import '../../data/requests/commiss_service_request.dart';
import '../../data/responses/commiss_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

class CommissService {
  final title = "CommissService";

  Future<CommissServiceResponse?> createCommiss(
    List<Commisss> listCommisss,
  ) async {
    apiUtils.secureHeaders = {
      'Authorization': 'Bearer ${window.sessionStorage["token"]}',
    };
    talker.debug(CommissServiceRequest(commisss: listCommisss).toJson());
    try {
      final response = await apiUtils.post(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.commiss,
        data: CommissServiceRequest(commisss: listCommisss),
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      CommissServiceResponse commissServiceResponse =
          CommissServiceResponse.fromJson(jsonDecode(response.toString()));
      talker.debug('code:: ${commissServiceResponse.code}');
      if (commissServiceResponse.code == "000") {
        return CommissServiceResponse(
          code: commissServiceResponse.code,
          message: response.data["message"],
          data: commissServiceResponse.data,
        );
      }
      return CommissServiceResponse.withError(
          code: CODE_RESPONSE_NULL, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return CommissServiceResponse.withError(
          code: CODE_ERROR, msg: apiUtils.handleError(e));
    }
  }

  Future<CommissServiceResponse?> listCommiss(
    Map<String, String> qParams,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
    // };
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.commiss,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      CommissServiceResponse commissServiceResponse =
          CommissServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("commissServiceResponse $commissServiceResponse");
      return commissServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
