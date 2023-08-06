import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/training_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class TrainingService {
  final title = "TrainingService";

  Future<TrainingServiceResponse?> listTraining(
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
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.training,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      TrainingServiceResponse trainingServiceResponse =
          TrainingServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("trainingServiceResponse $trainingServiceResponse");
      return trainingServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
