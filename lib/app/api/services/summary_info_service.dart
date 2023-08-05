import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../main.dart';
import '../../data/responses/summary_info_service_response.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class SummaryInfoService {
  final title = "SummaryInfoService";

  Future<SummaryInfoServiceResponse?> getSummaryInfo() async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
    // };
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.summaryInfo,
        // queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      SummaryInfoServiceResponse summaryInfoServiceResponse =
          SummaryInfoServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("summaryInfoServiceResponse $summaryInfoServiceResponse");
      return summaryInfoServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
