import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/member_position_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class MemberPositionService {
  final title = "MemberPositionService";

  Future<MemberPositionServiceResponse?> list(
    Map<String, String> qParams,
  ) async {
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.memberPosition,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      MemberPositionServiceResponse memberPositionServiceResponse =
          MemberPositionServiceResponse.fromJson(jsonDecode(response.toString()));
      return memberPositionServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
