import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../main.dart';
import '../../data/responses/station_service_response.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class StationService {
  final title = "StationService";

  Future<StationServiceResponse?> listSummaryInfo(
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
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.station,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      StationServiceResponse stationServiceResponse =
          StationServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("stationServiceResponse $stationServiceResponse");
      return stationServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
