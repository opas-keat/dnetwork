import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/commiss_position_commu_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class CommissPositionCommuService {
  final title = "CommissPositionCommuService";

  Future<CommissPositionCommuServiceResponse?> list(
    Map<String, String> qParams,
  ) async {
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext +
            Api.ectApiVersion +
            ApiEndPoints.commissPositionCommu,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      CommissPositionCommuServiceResponse commissPositionCommuServiceResponse =
          CommissPositionCommuServiceResponse.fromJson(
              jsonDecode(response.toString()));
      // talker.debug("commissPositionServiceResponse $commissPositionServiceResponse");
      return commissPositionCommuServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
