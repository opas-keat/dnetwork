import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/network_position_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class NetworkPositionService {
  final title = "NetworkPositionService";

  Future<NetworkPositionServiceResponse?> list(
    Map<String, String> qParams,
  ) async {
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.networkPosition,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      NetworkPositionServiceResponse networkPositionServiceResponse =
          NetworkPositionServiceResponse.fromJson(jsonDecode(response.toString()));
      return networkPositionServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
