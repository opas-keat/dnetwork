import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/lectuter_affiliate_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class LectuterAffiliateService {
  final title = "LectuterAffiliateService";

  Future<LectuterAffiliateServiceResponse?> list(
    Map<String, String> qParams,
  ) async {
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.lectuterAffiliate,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      LectuterAffiliateServiceResponse lectuterAffiliateServiceResponse =
          LectuterAffiliateServiceResponse.fromJson(jsonDecode(response.toString()));
      return lectuterAffiliateServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
