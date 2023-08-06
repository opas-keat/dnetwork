import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/village_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class VillageService {
  final title = "VillageService";

  Future<VillageServiceResponse?> listVillage(
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
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.village,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      VillageServiceResponse villageServiceResponse =
          VillageServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("commissServiceResponse $commissServiceResponse");
      return villageServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
