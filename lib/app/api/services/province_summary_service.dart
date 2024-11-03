import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/requests/dashboard_service_request.dart';
import '../../data/responses/province_summary_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class ProvinceSummaryService {
  final title = "ProvinceSummaryService";

  Future<ProvinceSummaryServiceResponse?> listProvinceSummary(
    String province,
    String stationNo,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
    // };
    Map<String, String> qParams = {
      // "offset": "0",
      // "limit": "20",
      // "order": "created_at",
      "province": province,
      "main_info_name": stationNo,
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

  Future<ProvinceSummaryServiceResponse?> update(
    List<Dashboards> listDashboards,
  ) async {
    talker.debug(DashboardServiceRequest(dashboards: listDashboards).toJson());
    try {
      final response = await apiUtils.put(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.provinceSummary}/status",
        data: DashboardServiceRequest(dashboards: listDashboards),
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      ProvinceSummaryServiceResponse provinceSummaryServiceResponse =
          ProvinceSummaryServiceResponse.fromJson(
              jsonDecode(response.toString()));
      return provinceSummaryServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
