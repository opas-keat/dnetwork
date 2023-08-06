import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/province_summary_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class ProvinceSummaryService {
  final title = "ProvinceSummaryService";

  Future<ProvinceSummaryServiceResponse?> listProvinceSummary(
    String province,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
    // };
    Map<String, String> qParams = {
      // "offset": "0",
      // "limit": "20",
      // "order": "created_at",
      "province": province,
    };
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext +
            Api.ectApiVersion +
            ApiEndPoints.provinceSummary,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      ProvinceSummaryServiceResponse provinceSummaryServiceResponse =
          ProvinceSummaryServiceResponse.fromJson(
              jsonDecode(response.toString()));
      // talker.debug("provinceSummaryServiceResponse $provinceSummaryServiceResponse");
      return provinceSummaryServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
