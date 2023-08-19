import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/training_type_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class TrainingTypeService {
  final title = "TrainingTypeService";

  Future<TrainingTypeServiceResponse?> list(
    Map<String, String> qParams,
  ) async {
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.trainingType,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      TrainingTypeServiceResponse trainingTypeServiceResponse =
          TrainingTypeServiceResponse.fromJson(jsonDecode(response.toString()));
      return trainingTypeServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
