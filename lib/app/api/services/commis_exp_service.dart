import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/commiss_exp_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class CommissExpService {
  final title = "CommissExpService";

  Future<CommissExpServiceResponse?> list(
    Map<String, String> qParams,
  ) async {
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.commissExp,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      CommissExpServiceResponse commissExpServiceResponse =
          CommissExpServiceResponse.fromJson(jsonDecode(response.toString()));
      return commissExpServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
