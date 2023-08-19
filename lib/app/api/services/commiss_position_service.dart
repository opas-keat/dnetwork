import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/commiss_position_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class CommissPositionService {
  final title = "CommissPositionService";

  Future<CommissPositionServiceResponse?> list(
    Map<String, String> qParams,
  ) async {
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext +
            Api.ectApiVersion +
            ApiEndPoints.commissPosition,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      CommissPositionServiceResponse commissPositionServiceResponse =
          CommissPositionServiceResponse.fromJson(
              jsonDecode(response.toString()));
      // talker.debug("commissPositionServiceResponse $commissPositionServiceResponse");
      return commissPositionServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
